Euler.register_language('coffeescript', Class.new do

  include FileUtils
  include Euler::Language

  language_name 'coffeescript'
  language_extension 'coffee'

  def run solution
    `coffee #{file_path(solution)}`
  end

  def init solution
    bootstrap_solution(solution)
    bootstrap_lib()
  end

end)
