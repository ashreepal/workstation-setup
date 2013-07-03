require_relative 'spec_helper'

describe_recipe 'setup::create_files' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  it 'creates the log file which contains the node object' do
    file("#{node['log_file_dir']}").must_exist
  end
end
