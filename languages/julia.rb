Euler.register_language('julia', Class.new do
  #Run the solution
  def run(solution)
    `julia #{file_path(solution)}`
  end

  #Copy the template into the solution's directory
  def init(solution)
    FileUtils.symlink("#{Euler.root}/lib/euler.jl", "#{solution.dir}/euler.jl")
  end

  private
    #Returns the path of the solution
    def file_path(solution)
      "#{solution.dir}/#{solution.problem.id}.jl"
    end

    def template_path
      "#{File.dirname(__FILE__)}/../templates/julia.jl"  
    end
end)