require 'fileutils'
require 'ostruct'

require 'euler/version'

require 'euler/errors'
require 'euler/problem'
require 'euler/solution'

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

  end

  def root
    File.dirname(__FILE__)
  end

end

# Default configuration options
Euler.config do |config|

  data_dir = "#{File.dirname(__FILE__)}/../data"

  config.answers_file "#{data_dir}/answers.yml"
  config.problems_dir "#{data_dir}/problems"

  config.directory_strategy lambda { |problem_id, language|
    "#{Euler.root}/#{problem_id}/#{language}"
  }

  config.create_directory_strategy lambda { |dir|
    FileUtils.mkdir_p(dir)
  }

end
