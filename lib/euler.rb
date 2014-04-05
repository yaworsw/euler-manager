require 'fileutils'
require 'ostruct'

require_relative 'euler/version'

require_relative 'euler/errors'
require_relative 'euler/problem'
require_relative 'euler/solution'

module Euler

  class ConfigOptions

    def initialize
      @config = OpenStruct.new
    end

    def method_missing method, *args, &block
      if args.empty?
        @config.send(method)
      else
        @config.send("#{method}=", args.first)
      end
    end

  end

  class << self

    @@config_options = Euler::ConfigOptions.new
    @@languages      = Hash.new

    def config
      yield @@config_options
    end

    # call without a second argument to unregister a language
    def register_language language_name, language = nil
      language_string = language_name.to_s
      @@languages[language_string.to_s] = language
    end

    def unregister_language language_name
      register_language(language_name)
    end

    def get_language language_name
      language_string = language_name.to_s
      if @@languages[language_string].nil?
        raise Euler::LanguageNotRegisteredError.new "#{language_string} has not been registered."
      else
        @@languages[language_string]
      end
    end

    def method_missing method, *args, &block
      temp = @@config_options.send method
      if temp.is_a?(Proc)
        temp.call *args
      else
        temp
      end
    end

    def root
      ENV['PWD']
    end

  end

end

# Default configuration options
Euler.config do |config|

  data_dir = "#{File.dirname(__FILE__)}/../data"

  config.answers_file "#{data_dir}/answers.yml"
  config.problems_dir "#{data_dir}/problems"

  config.directory_strategy Proc.new { |problem_id, language|
    "#{Euler.root}/#{problem_id}/#{language}"
  }

  config.create_directory_strategy Proc.new { |solution|
    problem = solution.problem
    dir     = solution.dir

    FileUtils.mkdir_p(dir)
    readme_path = "#{dir}/../README.md"
    if not File.exists?(readme_path) then File.open(readme_path, 'w') do  |f|
      f.write("# #{problem.name}\n\n#{problem.content}")
    end end
  }

end

require_relative 'euler/languages'
