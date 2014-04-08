Euler.register_language 'ruby', Class.new do

  def run solution
    `ruby #{file_path(solution)}`
  end

  def init solution
    File.open(file_path(solution), 'w') do |f|
      f.write('')
    end
  end

  private

    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.rb"
    end

end
