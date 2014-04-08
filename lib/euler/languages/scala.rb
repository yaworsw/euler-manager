Euler.register_language('scala', Class.new do

  # Compile and run the scala solution
  def run solution
    dir = File.dirname(file_path(solution))
    Dir.chdir(dir)
    `scalac -classpath .:#{Euler.root}/lib *.scala && scala Main`
  end

  # Copy the scala template to the solution directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path of the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.scala"
    end

    # Returns the path of the scala template
    def template_path
      "#{File.dirname(__FILE__)}/templates/scala.rb"
    end

end)
