require 'yaml'

module Euler

  class Problem

    attr_reader :id, :name, :content

    def find id
      problem_spec_file = "#{Euler.problems_dir}/#{problem_id}.yml"
      problem_spec      YAML.load_file(problem_spec_file)
      PRoblem.new problem_spec
    end

    def initialize options
      @id      = options[:id]
      @name    = options[:name]
      @content = options[:content]
    end

    def to_hash
      {
        id:       id,
        name:     name,
        content:  content
      }
    end

    def to_yaml
      to_hash.to_yaml
    end

  end

end

