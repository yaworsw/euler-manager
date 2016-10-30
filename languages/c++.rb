Euler.register_language('c++', Class.new do
  def run solution
    dir = File.dirname(file_path(solution))
    Dir.chdir(dir)
    `g++ #{file_path(solution)} -o #{solution.dir}/solution`
    `#{solution.dir}/solution`
  end

  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.cpp"
    end

    def template_path
      "#{File.dirname(__FILE__)}/../templates/cplusplus.cpp"
    end
end)
