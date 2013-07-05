require_relative 'spec_helper'

describe_recipe 'setup::create_files' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  it 'creates the creds_file_dir' do
    file("#{node['creds_file_dir']}").must_exist
  end
end
