# gst - GNU Smalltalk
Euler.register_language('gst', Class.new do

  # Run the ruby solution
  def run solution
    `gst #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.st"
    end

    def template_path
      "#{File.dirname(__FILE__)}/../templates/gst.st"
    end

end)
