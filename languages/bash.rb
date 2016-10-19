Euler.register_language('bash', Class.new do

  # Run the bash solution
  def run solution
    `. #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path to the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.sh"
    end

    # Returns the path to the ruby template
    def template_path
      "#{File.dirname(__FILE__)}/../templates/bash.sh"
    end

end)
