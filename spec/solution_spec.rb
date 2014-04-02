require 'spec_helper'

describe Euler::Solution do

  before(:all) do
    Euler.config do |config|

    end
  end

  it "should call it's language's run method when run is called" do
    euler_lang = Class.new do
      def run; end
    end

    euler_lang.should_receive(:run).once

    Euler.register_language('euler-lang', euler_lang)

    solution = Euler::Solution.new(9001, 'euler-lang')
    solution.run

    Euler.unregister_language('euler-lang')
  end

  it "should raise an error if it's initialized before it's language is registered" do
    expect {
      Euler::Solution.new(9001, 'euler-lang')
    }.to raise_error Euler::LanguageNotRegisteredError
  end

end
