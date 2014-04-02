require 'ostruct'

require 'euler/version'

require 'euler/problem'
require 'euler/solution'

module Euler

  class << self

    @@config_options = OpenStruct.new
    @@languages      = {}

    def config
      yield @@config_options
    end

    def register_language name, language
      @@languages[name.to_s] = language
    end

    def get_language name
      @@languages[name.to_s]
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
