require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'euler'
require 'fakefs/spec_helpers'
