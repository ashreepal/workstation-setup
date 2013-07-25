require 'yaml'

# records path to important files that will need to be accessed by the runner later
paths = {}
paths['config'] = node['config_file_dir']
paths['custom'] = node['custom_file_dir']

node[:deploy].each do |application, deploy|
  paths['workflows'] = node['workflow-paths'].map { |p| "#{deploy[:deploy_to]}/current/#{p}" }
  paths['activities'] = node['activity-paths'].map { |p| "#{deploy[:deploy_to]}/current/#{p}" }
end

directory "#{node['paths_folder_dir']}" do
  mode '0755'
  owner node['user']
  group node['group']
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['paths_folder_dir'])
  end

end.run_action(:create)

file node['paths_file_dir'] do
  mode '0755'
  owner node['user']
  group node['group']
  content paths.to_yaml
  action :nothing

  only_if do
    ::File.exists?(node['paths_folder_dir'])
  end

end.run_action(:create)
