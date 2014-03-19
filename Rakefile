# coding:utf-8
$:.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["--color", "--backtrace", "-f documentation", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rspec_opts = ["--color", "--backtrace", "-f documentation", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
  t.rcov_opts =  %q[--exclude "gems, spec"]
end

task :default => :spec
