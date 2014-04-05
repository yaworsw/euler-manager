require 'yaml'

module Euler

  class Problem

    def self.find id
      problem_spec_file = "#{Euler.problems_dir}/#{id}.yml"
      problem_spec      = YAML.load_file(problem_spec_file)
      Problem.new problem_spec
    end

    attr_reader :id, :name, :content

    def initialize options
      @id      = options[:id]
      @name    = options[:name]
      @content = options[:content]
    end

    def has_answer?
      not answer.empty?
    end

    def answer
      @@answers ||= YAML.load_file(Euler.answers_file)
      @@answers[id].to_s
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

