Euler.register_language('javascript', Class.new do

  # Run the solution
  def run solution
    `node #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path to the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.js"
    end

    # Returns the path to the template
    def template_path
      "#{File.dirname(__FILE__)}/templates/javascript.js"
    end

end)
