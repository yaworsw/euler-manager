Euler.register_language('ruby', Class.new do

  # Run the ruby solution
  def run solution
    `ruby #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path to the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.rb"
    end

    # Returns the path to the ruby template
    def template_path
      "#{File.dirname(__FILE__)}/templates/ruby.rb"
    end

end)
