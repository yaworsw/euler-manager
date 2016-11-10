Euler.register_language('rust', Class.new do

  # Compile and run the rist solution
  def run solution
    Dir.chdir(solution.dir)
    `cargo run -q`
  end

  # Initialize the solution directory with Cargo and copy the
  # rust template into it. This allows the user to add dependencies
  # to Cargo.toml if necessary.
  def init solution
    `cargo init #{solution.dir} --name #{solution.problem.id} --bin -q`
    FileUtils.cp(template_path, file_path(solution))
  end

  private

  # Returns the path of the solution
  def file_path solution
    "#{solution.dir}/src/main.rs"
  end

  # Returns the path of the rust template
  def template_path
    "#{File.dirname(__FILE__)}/../templates/rust.rs"
  end

end)
