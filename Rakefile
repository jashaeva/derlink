#-*- coding: utf-8 -*-

require "rubygems"
require 'bundler/setup'

require "rspec/core/rake_task"

TEST_HOME = File.expand_path(File.dirname(__FILE__))

desc "The *features tests"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.fail_on_error = false
  t.rspec_opts = %w[--color]
  t.verbose = false
  t.pattern = "#{TEST_HOME}/spec/**/*feature.rb"    
end

desc "Defaults" 
task :default => :spec