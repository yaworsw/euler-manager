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

    def init

      language_object.init
    end

    def run
      language_object.run
    end

    private

      def language_object
        Euler.get_language(language)
      end

  end

end
