Euler.register_language('scala', Class.new do

  # Compile and run the scala solution
  def run solution
    dir = File.dirname(file_path(solution))
    Dir.chdir(dir)
    `scalac #{Euler.root}/lib/*.scala && scalac -cp .:#{Euler.root}/lib ./*.scala && scala Main`
  end

  # Init initializes a solution.
  #
  # The solution's directory is created before init is ran.
  #
  # This init method copys a starter scala file into the solution's directory
  # and creates a starter euler.scala in the lib directory if one does not
  # exist.
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
      "#{solution.dir}/#{solution.problem.id}.scala"
    end

    def solution_template_path
      "#{File.dirname(__FILE__)}/../templates/solution/scala.scala"
    end

    def lib_template_path
      "#{File.dirname(__FILE__)}/../templates/lib/scala.scala"
    end

    def lib_path
      "#{Euler.root}/lib/euler.scala"
    end

end)
