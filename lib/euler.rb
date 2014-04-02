require 'ostruct'

require 'euler/version'

require 'euler/errors'
require 'euler/problem'
require 'euler/solution'

module Euler

  class << self

    @@config_options = OpenStruct.new
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

  data_dir = "#{__dir__}/../data"

  config.answers_file = "#{data_dir}/answers.yml"
  config.problems_dir = "#{data_dir}/problems"

end
