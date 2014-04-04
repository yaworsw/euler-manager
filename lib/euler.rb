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

  end

  def method_missing method, *args, &block
    if args.empty?
      @@config_options.send method
    else
      super
    end
  end

end

# Default configuration options
Euler.config do |config|

  data_dir = "#{File.dir_name(__FILE__)}/../data"

  config.answers_file "#{data_dir}/answers.yml"
  config.problems_dir "#{data_dir}/problems"

  config.directory_stragety do |problem_id, language|
    dir = "#{Euler.root}/#{problem_id}/#{language}"
    FileUtils::mkdir_p(dir)
  end

  config.create_directory_stragety do |problem_id, langauge|
    "#{Euler.root}/#{problem_id}/#{language}"
  end

end
