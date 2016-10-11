Euler.register_language('c', Class.new do
  def run solution
    dir = File.dirname(file_path(solution))
    Dir.chdir(dir)
    `gcc #{file_path(solution)} -o #{solution.dir}/solution`
    `#{solution.dir}/solution`
  end

  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.c"
    end

    def template_path
      "#{File.dirname(__FILE__)}/../templates/c.c"
    end
end)
