Euler.register_language('python', Class.new do

  # Run the solution
  def run solution
    `python #{file_path(solution)}`
  end

  # Init initializes a solution.
  #
  # The solution's directory is created before init is ran.
  #
  # This init method copys a starter python file into the solution's
  # directory and creates a starter euler.py in the lib directory if one
  # does not exist.  Also this init method symlinks the euler.py into the
  # solution's directory.
  def init solution
    solution_file = file_path(solution)
    FileUtils.cp(solution_template_path, solution_file) unless File.exist?(solution_file)

    FileUtils.cp(lib_template_path, lib_path) unless File.exist?(lib_path)

    FileUtils.symlink("#{Euler.root}/lib/euler.py", "#{solution.dir}/euler.py")
  end

  private

    def lib_exists?
      File.exist?(lib_path)
    end

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.py"
    end

    def solution_template_path
      "#{File.dirname(__FILE__)}/../templates/solution/python.py"
    end

    def lib_template_path
      "#{File.dirname(__FILE__)}/../templates/lib/python.py"
    end

    def lib_path
      "#{Euler.root}/lib/euler.py"
    end

end)
