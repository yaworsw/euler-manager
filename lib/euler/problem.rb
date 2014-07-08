require 'yaml'

module Euler

  # This class represents a project Euler problem.

  class Problem

    # Returns the problem with the given id.
    def self.find id
      problem_spec_file = "#{Euler.problems_dir}/#{id}.yml"
      problem_spec      = YAML.load_file(problem_spec_file)
      Problem.new problem_spec
    end

    attr_reader :id, :name, :url

    # Given a hash with symbol keys initialize the problem using the +:id+,
    # +:name+, +url+, and +:content+ keys.
    def initialize options
      @id      = options[:id]
      @name    = options[:name]
      @url     = options[:url]
      @content = options[:content]
    end

    # Content without going through the template engine
    def template
      @content
    end

    # Passing content though an ultra simple template engine before returning it
    def content
      @content.gsub(/\{\{\s?images_dir\s?\}\}/, Euler.images_dir)
    end

    # Returns true if this problem has an answer.
    def has_answer?
      not answer.empty?
    end

    # Returns this problem's answer.
    def answer
      @@answers ||= YAML.load_file(Euler.answers_file)
      @@answers[id].to_s
    end

    # Converts the problem to a hash.
    def to_hash
      {
        id:       id,
        name:     name,
        url:      url,
        content:  template
      }
    end

    # Converts the problem to YAML.
    def to_yaml
      to_hash.to_yaml
    end

    def to_s
      "##{id} - #{name}"
    end

  end

end

