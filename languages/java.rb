Euler.register_language('java', Class.new do

  # Compile and run the java solution
  def run solution
    dir = File.dirname(file_path(solution))
    Dir.chdir(dir)
    libs = Dir["#{Euler.root}/lib/**/*.java"].reject { |f| File.basename(f) == 'java.java' }
    libs.each { |lib| `javac #{lib}` }
    `javac -cp .:#{Euler.root}/lib ./*.java && java Main`
  end

  # Copy the java template to the solution directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    # Returns the path of the solution
    def file_path solution
      "#{solution.dir}/Main.java"
    end

    # Returns the path of the java template
    def template_path
      "#{File.dirname(__FILE__)}/../templates/java.java"
    end

end)
