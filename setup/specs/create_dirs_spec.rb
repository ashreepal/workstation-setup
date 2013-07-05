require_relative 'spec_helper'

describe_recipe 'setup::create_dirs' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  it 'creates all the directories into creds_folder_dir' do
    file("#{node['creds_folder_dir']}").must_exist
  end
  
  it 'creates all the directories into log_folder_dir' do
    file("#{node['log_folder_dir']}").must_exist
  end
end
