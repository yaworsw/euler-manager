module Euler

  class Solution

    attr_accessor :language

    def initialize problem, language
      if problem.is_a?(Problem)
        @problem    = problems
      else
        @problem_id = problem
      end
      @language = language
    end

    def problem
      @problem ||= Problem.find(@problem_id)
    end

    def problem_id
      @problem_id ||= @problem.id
    end

    def init
      mkdir
      if language_object.respond_to?(:init)
        language_object.init(self)
      end
      self
    end

    def answer
      problem.answer
    end

    def run
      @result ||= language_object.run(self)
    end

    def result
      run
    end

    def test
      expected =  answer
      result   =  run
      expected == result
    end

    def correct?
      test
    end

    def dir
      Euler.directory_strategy(problem_id, language)
    end

    protected

      def mkdir
        Euler.create_directory_strategy(self)
      end

      def language_object
        Euler.get_language(language)
      end

  end

end
