module Euler
  module Language

    include FileUtils

    attr_accessor :language_name, :language_extension, :capitalize_lib,
      :solution_name_strategy

    attr_writer :lib_name

    def initialize
      @solution_name_strategy = lambda { |solution|
        solution.problem.id
      }
    end

    def bootstrap_solution solution
      solution_file = file_path(solution)
      cp(solution_template_path, solution_file) unless File.exist?(solution_file)
    end

    def bootstrap_lib
      mkdir_p(File.dirname(lib_name))
      cp(lib_template_path, lib_path) unless File.exist?(lib_path)
    end

    def file_path solution
      file_name = "#{solution_name_strategy(solution)}.#{language_extension}"
      "#{solution.dir}/#{file_name}"
    end

    def lib_path
      "#{Euler.root}/lib/#{lib_name}"
    end

    def lib_template_path
      "#{File.dirname(__FILE__)}/../../templates/solution/#{language_name}.#{language_extension}"
    end

    protected

      def lib_name
        lib_name || "#{capitalize_lib ? 'E' : 'e'}uler.#{language_extension}"
      end

  end
end
