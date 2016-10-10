# Initialize the Euler module's configuration to the default values.
Euler.config do |config|

  data_dir = "#{File.dirname(__FILE__)}/../data"

  config.answers_file "#{data_dir}/answers.yml"
  config.problems_dir "#{data_dir}/problems"
  config.images_dir   "#{data_dir}/images"

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

# Loads the default language definitions.
[

  'c',
  'coffeescript',
  'elixir',
  'haskell',
  'java',
  'javascript',
  'julia',
  'perl',
  'php',
  'python',
  'ruby',
  'scala'

].each do |lang|
  require_relative "../languages/#{lang}"
end

# Attempt to load user defined configuration
begin
  require Euler.euler_file_path
rescue; end
