Euler.register_language('java', Class.new do

  # Compile and run the java solution
  def run solution
    dir = File.dirname(file_path(solution))
    Dir.chdir(dir)
    `find #{Euler.root}/lib -type f -name "*.java" -not -name "java.java" -print | xargs javac`
    `javac -cp .:#{Euler.root}/lib ./*.java && java Main`
  end

  # Init initializes a solution.
  #
  # The solution's directory is created before init is ran.
  #
  # This init method copys a starter java file into the solution's directory and
  # creates a starter euler.java in the lib directory if one does not exist.
  def init solution
    solution_file = file_path(solution)
    FileUtils.cp(solution_template_path, solution_file) unless File.exist?(solution_file)

    FileUtils.cp(lib_template_path, lib_path) unless File.exist?(lib_path)
  end

  private

    def lib_exists?
      File.exist?(lib_path)
    end

    def file_path solution
      "#{solution.dir}/Main.java"
    end

    def solution_template_path
      "#{File.dirname(__FILE__)}/../templates/solution/java.java"
    end

    def lib_template_path
      "#{File.dirname(__FILE__)}/../templates/lib/java.java"
    end

    def lib_path
      "#{Euler.root}/lib/Euler.java"
    end

end)
