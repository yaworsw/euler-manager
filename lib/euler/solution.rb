module Euler

  class Solution

    attr_accessor :language

    def initialize problem, language
      if problem.is_a?(Problem)
        @problem    = problem
      else
        @problem_id = problem
      end
      @language = Euler.get_language(language)
    end

    def problem
      @problem ||= Problem.find(@problem_id)
    end

    def init
      language.init
    end

    def run
      language.run
    end

  end

end
