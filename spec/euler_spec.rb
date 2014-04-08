require 'spec_helper'

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

end
