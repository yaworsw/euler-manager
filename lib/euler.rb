require 'fileutils'
require 'ostruct'

require_relative 'euler/version'

require_relative 'euler/errors'
require_relative 'euler/problem'
require_relative 'euler/solution'

module Euler

  # This class holds the Euler module's configuration.

  class ConfigOptions

    # Initialize an empty OpenStruct to hold configuration options
    def initialize
      @config = OpenStruct.new
    end

    # To set a config option call the corresponding method with an argument.
    # To retrieve a config option call the corresponding method without an argument.
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

    # Yields config_options to a block.  Used to configure the Euler module.
    def config
      yield @@config_options
    end

    # Register a language by calling this method with the languages name and the
    # class for that language.  To unregister a language call this method
    # without a second argument.
    #
    # Language classes require a +run+ method which accepts an +Euler::Solution+
    # and returns the result of running the solution.  Optionally language
    # classes can also have an +init+ method which also accepts a solution.  The
    # +init+ method does any extra steps required in initializing an empty
    # solution.
    def register_language language_name, language = nil
      language_string = language_name.to_s
      @@languages[language_string.to_s] = language
    end

    # Unregisters a language
    def unregister_language language_name
      register_language(language_name)
    end

    # Returns an instance of a registered language class.
    #
    # @throws Euler::LanguageNotRegisteredError if the language asked for has
    # not already been registered.
    def get_language language_name
      language_string = language_name.to_s
      if @@languages[language_string].nil?
        raise Euler::LanguageNotRegisteredError.new "#{language_string} has not been registered."
      else
        @@languages[language_string].new
      end
    end

    # Returns configuration options.  If the configuration option is a +Proc+
    # then this method will call it with the arguments passed to this method and
    # return the result.
    def method_missing method, *args, &block
      temp = @@config_options.send method
      if temp.is_a?(Proc)
        temp.call *args
      else
        temp
      end
    end

    # Returns the root directory of the current project.
    def root
      root = ENV['PWD']
      until File.exists?("#{root}/Eulerfile.rb") || File.expand_path(root) == '/' do
        root = File.dirname(root)
      end
      if not File.exists?("#{root}/Eulerfile.rb")
        raise Euler::EulerFileNotFoundError.new "Unable to find an Eulerfile.rb in any of the parent directories."
      end
      root
    end

    # Returns an array with the first element being the problem id and the
    # second element being the language gotten from either the args passed in or
    # by parsing the directory the command was ran from
    def params_from_dir_or_args args
      from_dir = parse_params_from_directory
      [
        args.shift || from_dir.shift,
        args.shift || from_dir.shift
      ]
    end

    # Uses the +directory_parse_strategy+ to attempt to parse the problem id and
    # language of the solution's directory the command was ran from.
    def parse_params_from_directory dir = ENV['PWD']
      self.directory_parse_strategy(dir)
    end

  end

end

# Initialize the Euler module's configuration to the default values.
Euler.config do |config|

  data_dir = "#{File.dirname(__FILE__)}/../data"

  config.answers_file "#{data_dir}/answers.yml"
  config.problems_dir "#{data_dir}/problems"

  # The +directory_strategy+ is a Proc which returns the directory assigned to a
  # a given solution.
  config.directory_strategy lambda { |solution|
    "#{Euler.root}/#{solution.problem_id}/#{solution.language}"
  }

  # The +create_directory_strategy+ is a Proc which is ran to create directories
  # for solutions and anything else that is required to initialize a solution.
  # By default a +README.md+ file is created at the root of the problem with the
  # problem's name and description.
  config.create_directory_strategy lambda { |solution|
    problem = solution.problem
    dir     = solution.dir

    FileUtils.mkdir_p(dir)
    readme_path = "#{dir}/../README.md"
    if not File.exists?(readme_path) then File.open(readme_path, 'w') do |f|
      f.write("# #{problem.name}\n\n#{problem.content}")
    end end
  }

  # Attempts to parse a directory for the +problem_id+ and +language+.  Returns
  # a an array where the first element is the problem id and the second element
  # is the language.
  config.directory_parse_strategy lambda { |dir|
    problem_id = (Regexp.new("#{Euler.root}/(\\d+)").match(dir)     || [])[1]
    language   = (Regexp.new("#{Euler.root}/\\d+/(.+)").match(dir)  || [])[1]

    [problem_id, language]
  }

end

# Include the default language definitions.
require_relative 'euler/languages'

# @todo include Euler file
