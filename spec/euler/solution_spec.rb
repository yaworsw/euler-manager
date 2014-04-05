require 'spec_helper'

class EulerLang
  def run; end
end

describe Euler::Solution do

  before(:all) do
    Euler.config do |config|

    end
  end

  def register_euler_lang
    euler_lang = EulerLang.new
    Euler.register_language('euler-lang', euler_lang)
    euler_lang
  end

  def unregister_euler_lang
    Euler.unregister_language('euler-lang')
  end

  it "should call it's language's run method when run is called" do
    register_euler_lang.should_receive(:run).once

    solution = Euler::Solution.new(9001, 'euler-lang')
    solution.run

    unregister_euler_lang
  end

  it "should raise an error if run is called before it's language is registered" do
    expect {
      solution = Euler::Solution.new(9001, 'euler-lang')
      solution.run
    }.to raise_error Euler::LanguageNotRegisteredError
  end

  it "should attempt to create the directory specified by directory_strategy when init is called" do
    include FakeFS::SpecHelpers
    FakeFS.activate!

    register_euler_lang

    ds = lambda { |problem_id, language|
      "/euler/#{problem_id}/#{language}"
    }

    args = [1, 'euler-lang']

    Euler.config do |config|
      config.directory_strategy ds
    end

    Euler::Solution.new(*args).init

    dir = ds.call(*args)

    File.directory?(dir).should be_true

    unregister_euler_lang
  end

end
