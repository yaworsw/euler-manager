Euler.register_language('python', Class.new do

  # Run the solution
  def run solution
    `python #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.symlink("#{Euler.root}/lib/euler.py", "#{solution.dir}/euler.py")

    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path to the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.py"
    end

    # Returns the path to the template
    def template_path
      "#{File.dirname(__FILE__)}/../templates/python.py"
    end

end)
