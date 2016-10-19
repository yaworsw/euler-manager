require 'spec_helper'

require_relative '../config/languages'

describe Euler do

  before(:all) do
    Euler.config do |config|

    end
  end

  it "should be able to set config options with lambdas" do
    ds = lambda { |solution|

    }

    args = [1, 'euler-lang']

    ds.should_receive(:call).once.with(*args)

    Euler.config do |config|
      config.directory_strategy ds
    end

    Euler.directory_strategy *args
  end

  it "should have a few languages preregistered" do
    $supportedLanguagesList.each do |lang|
      Euler.get_language(lang).should be_truthy
    end
  end

  describe "Ruby language" do

    it "'s template should be a file" do
      ruby = Euler.get_language('ruby')
      tmpl = ruby.send(:template_path)
      File.exists?(tmpl).should be_truthy
    end

  end

end
