require 'yaml'

paths = {}
paths['config'] = node['config_file_dir']
paths['custom'] = node['custom_file_dir']

Chef::Log.info("type of node[:deploy]: #{node[:deploy].class}")
Chef::Log.info("type of node: #{node.class}")

node[:deploy].each do |application, deploy|
  paths['workflows'] = node['workflow-paths'].map { |p| "#{deploy[:deploy_to]}/current/#{p}" }
  paths['activities'] = node['activity-paths'].map { |p| "#{deploy[:deploy_to]}/current/#{p}" }
end

directory "#{node['paths_folder_dir']}" do
  mode '0755'
  owner 'root'
  group 'root'
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['paths_folder_dir'])
  end

end.run_action(:create)

file node['paths_file_dir'] do
  mode '0755'
  owner 'root'
  group 'root'
  content paths.to_yaml
  action :nothing

  only_if do
    ::File.exists?(node['paths_folder_dir'])
  end

end.run_action(:create)
