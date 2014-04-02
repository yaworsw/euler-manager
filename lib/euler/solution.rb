module Euler

  class Solution

    attr_accessor :language

    def initialize problem, language
      if problem.is_a?(Problem)
        @problem    = problem
      else
        @problem_id = problem
      end
      @language = language.to_sym
    end

    def problem
      @problem ||= Problem.find(@problem_id)
    end

    def run
      lang = Euler.get_language(language)
      lang.run
    end

  end

end
