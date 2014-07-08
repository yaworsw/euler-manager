Euler.register_language('julia', Class.new do
  #Run the solution
  def run(solution)
    `julia #{file_path(solution)}`
  end

  #Copy the template into the solution's directory
  def init(solution)
    FileUtils.symlink(lib_path, "#{solution.dir}/euler.jl")

    FileUtils.cp(template_path, file_path(solution))
  end

  private

    #Returns the path of the solution
    def file_path(solution)
      "#{solution.dir}/#{solution.problem.id}.jl"
    end

    # Returns the path to the template
    def template_path
      "#{File.dirname(__FILE__)}/../templates/julia.jl"
    end

    # Returns the path to the template
    def lib_path
      "#{Euler.root}/lib/euler.jl"
    end

end)
