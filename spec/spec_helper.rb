# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper.rb"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'rr'
require_relative '../lib/xcodeproject/project'
require_relative '../lib/xcodeproject/exceptions'
require_relative 'support/shared_examples/file_node_shared_examples'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.mock_with :rr
end

#	Example project file hierarhy
#
# main
# \--group1a
#    |--group2a
#    |--dir2c
#    |   \--dir3a
#    |      \--dir4a
#    |         |--file5a-a.m
#    |         |--file5a-a.h
#    |         |--file5a-r.m
#    |         \--file5a-r.h
#    |
#    |--file2c.m
#    \--file2c.h

def prepare_sandbox
  ` mkdir -p #{example_sandbox_path} ` unless File.exist?(example_sandbox_path)
end

def prepare_example_project
  prepare_sandbox

  proj_source_dir = "#{File.dirname(__FILE__)}/../resources/example"
  ` rm -vr #{example_project_dir} `
  ` cp -vr #{proj_source_dir} #{example_sandbox_path} `

  XcodeProject::Project.new(example_project_bundle_path)
end

def example_sandbox_path
  Pathname.new('/tmp/example_sandbox')
end

def example_empty_sandbox_path
  Pathname.new('/tmp/example_sandbox_empty')
end

def example_project_dir
  example_sandbox_path.join('example')
end

def example_project_bundle_path
  example_project_dir.join('example.xcodeproj')
end

def example_project_file_path
  example_project_bundle_path.join('project.pbxproj')
end
