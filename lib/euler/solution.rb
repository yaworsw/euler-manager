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
      if language_object.respond_to? :init
        language_object.init
      end
    end

    def run
      language_object.run
    end

    def dir
      Euler.directory_strategy(problem_id, language)
    end

    protected

      def mkdir
        FileUtils.mkdir_p(dir)
      end

      def language_object
        Euler.get_language(language)
      end

  end

end
