module Euler

  # This class represents a user created solution to a project Euler problem.

  class Solution

    # Returns an array of all of the solutions
    def self.all
      Euler.all_solutions_strategy
    end

    attr_reader :language

    # Given the problem this solution is for an the language it's implemented in
    # initialize the instance.
    def initialize problem, language
      if problem.is_a?(Problem)
        @problem    = problems
      else
        @problem_id = problem
      end
      @language = language
    end

    # Returns the problem this solution is for.
    def problem
      @problem ||= Problem.find(@problem_id)
    end

    # Returns the id of the problem this solution is for.
    def problem_id
      @problem_id ||= @problem.id
    end

    # Initialize this solution.  This means:
    #
    # - run the +create_directory_strategy+ to initialize the solutions
    # directory.
    # - Run this solution's language's init method to do any extra
    # initialization steps required by the language.
    def init
      mkdir
      if language_object.respond_to?(:init)
        language_object.init(self)
      end
      self
    end

    # Returns this solution's answer.
    def answer
      problem.answer
    end

    # Returns the result of running this solution.
    def run
      @result ||= language_object.run(self)
    end

    # Alias for +run+.
    def result
      run
    end

    # Returns true if this solution is correct.
    def test
      expected =  answer
      result   =  run
      expected == result
    end

    # Alias for +test+.
    def correct?
      test
    end

    # Returns the directory assigned to this solution by calling
    # +Euler.directory_strategy+.
    def dir
      Euler.directory_strategy(self)
    end

    protected

      # Used to create this solution's directory.
      def mkdir
        Euler.create_directory_strategy(self)
      end

      # Returns the object instance of the class which represents this
      # solution's language.  Not to be confused with +language+ which just
      # returns the name of the solutions language.
      def language_object
        @language_object ||= Euler.get_language(language)
      end

  end

end
