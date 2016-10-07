Euler.register_language('perl', Class.new do

  # Run the solution
  def run solution
    `perl #{file_path(solution)}`
  end
  
  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end
 
  private
  
    # Returns the path to the solution
    def file_path solution
      "#{solution.dir}/#{solution.problem.id}.pl"
    end
    
  # Returns the path to the template
  def template_path
    "#{File.dirname(__FILE__)}/../templates/perl.pl"
  end
  
end)