Euler.register_language('ruby', Class.new do

  # Run the ruby solution
  def run solution
    `ruby #{file_path(solution)}`
  end

  # Init initializes a solution.
  #
  # The solution's directory is created before init is ran.
  #
  # This init method copys a starter ruby file into the solution's directory
  # and creates a starter euler.rb in the lib directory if one does not exist.
  def init solution
    solution_file = file_path(solution)
    FileUtils.cp(solution_template_path, solution_file) unless File.exist?(solution_file)

    FileUtils.cp(lib_template_path, lib_path) unless File.exist?(lib_path)
  end

  private

    def lib_exists?
      File.exist?(lib_path)
    end

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.rb"
    end

    def solution_template_path
      "#{File.dirname(__FILE__)}/../templates/solution/ruby.rb"
    end

    def lib_template_path
      "#{File.dirname(__FILE__)}/../templates/lib/ruby.rb"
    end

    def lib_path
      "#{Euler.root}/lib/euler.rb"
    end

end)
