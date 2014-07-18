# The Eulerfile.rb has user specific configuration.
#
# The location of the answers file and problems directory are both configurable.
# Additionally the strategy used to assign solutions directories, to create
# those directories, and to parse the directory the the +euler+ command is being
# ran from are all also configurable.  See below for an example configuration.

Euler.config do |config|

  data_dir = "#{File.dirname(__FILE__)}/../data"

  config.answers_file "#{data_dir}/answers.yml"
  config.problems_dir "#{data_dir}/problems"
  config.images_dir   "https://raw.githubusercontent.com/yaworsw/euler-manager/develop/data/images"

  # The +directory_strategy+ is a Proc which returns the directory assigned to a
  # a given solution.
  config.directory_strategy lambda { |solution|
    "#{Euler.root}/#{solution.problem_id}/#{solution.language}"
  }

  # The +create_directory_strategy+ is a Proc which is ran to create directories
  # for solutions and anything else that is required to initialize a solution.
  # By default a +README.md+ file is created at the root of the problem with the
  # problem's name and description.
  config.create_directory_strategy lambda { |solution|
    problem = solution.problem
    dir     = solution.dir

    FileUtils.mkdir_p(dir)
    readme_path = "#{dir}/../README.md"
    if not File.exists?(readme_path) then File.open(readme_path, 'w') do |f|
      f.write("# [#{problem.name}](#{problem.url})\n\n#{problem.content}")
    end end
  }

  # Attempts to parse a directory for the +problem_id+ and +language+.  Returns
  # a an array where the first element is the problem id and the second element
  # is the language.
  config.directory_parse_strategy lambda { |dir|
    problem_id = (Regexp.new("#{Euler.root}/(\\d+)").match(dir)     || [])[1]
    language   = (Regexp.new("#{Euler.root}/\\d+/(.+)").match(dir)  || [])[1]

    [problem_id, language]
  }

  # Returns every solution done so far.
  config.all_solutions_strategy lambda {
    Dir["#{Euler.root}/*"].select { |f|
      File.directory?(f) and /\/\d+$/ === f
    }.map { |problem_dir|
      Dir["#{problem_dir}/*"].map { |solution_dir|
        if File.directory?(solution_dir)
          args = Euler.parse_params_from_directory(solution_dir)
          Euler::Solution.new(*args)
        else
          nil
        end
      }
    }.flatten.compact
  }

end

# It can also register or language classes which are used to initialize and run
# problems.

Euler.register_language('python', Class.new do

  # Run the solution
  def run solution
    `python #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    rel_euler_root = solution.dir.gsub(Euler.root, '').gsub(/\/[^\/]+/, '/..').sub(/^\//, '')
    old_dir        = Dir.pwd

    Dir.chdir solution.dir

    FileUtils.symlink("#{rel_euler_root}/lib/euler.py", "#{solution.dir}/euler.py")

    Dir.chdir old_dir

    FileUtils.touch(file_path(solution))
  end

  private

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.py"
    end

end)

