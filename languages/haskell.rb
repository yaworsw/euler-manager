Euler.register_language('haskell', Class.new do

  # Run the solution
  def run solution
    `ghc #{file_path(solution)} > /dev/null && #{exec_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path to the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.hs"
    end

    # Returns the path to the executable
    def exec_path solution
      "#{solution.dir}/#{solution.problem.id}"
    end

    # Returns the path to the template
    def template_path
      "#{File.dirname(__FILE__)}/../templates/haskell.hs"
    end

end)
