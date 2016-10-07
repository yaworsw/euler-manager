Euler.register_language('elixir', Class.new do

  # Compile and run the solution
  def run solution
    `elixir #{file_path(solution)}`
  end

  # Copy the template to the solution directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path of the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.ex"
    end

    # Returns the path of the template
    def template_path
      "#{File.dirname(__FILE__)}/../templates/elixir.ex"
    end

end)
