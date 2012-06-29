#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.fail_on_error = true
  t.verbose = true
  t.rspec_opts ||= []
  t.rspec_opts << "-r ./spec/spec_helper"
  t.rspec_opts << "--color"
  t.rspec_opts << "-fd"
end

task default: :spec
task test: :spec

desc "open console (require limbo)"
task :c do
  system "irb -I lib -r limbo"
end
