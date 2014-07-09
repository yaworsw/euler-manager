Euler.register_language('julia', Class.new do

  # Run the solution
  def run(solution)
    `julia #{file_path(solution)}`
  end

  # Init initializes a solution.
  #
  # The solution's directory is created before init is ran.
  #
  # This init method copys a starter julia file into the solution's directory
  # and creates a starter euler.jl in the lib directory if one does not exist.
  def init solution
    solution_file = file_path(solution)
    FileUtils.cp(solution_template_path, solution_file) unless File.exist?(solution_file)

    FileUtils.cp(lib_template_path, lib_path) unless File.exist?(lib_path)
  end

  private

    def lib_exists?
      File.exist?(lib_path)
    end

    def file_path(solution)
      "#{solution.dir}/#{solution.problem.id}.jl"
    end

    def solution_template_path
      "#{File.dirname(__FILE__)}/../templates/solution/julia.jl"
    end

    def lib_template_path
      "#{File.dirname(__FILE__)}/../templates/lib/julia.jl"
    end

    def lib_path
      "#{Euler.root}/lib/euler.jl"
    end

end)
