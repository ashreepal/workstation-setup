require 'yaml'

paths = {}
paths['config'] = node['config_file_dir']
paths['custom'] = node['custom_file_dir']
paths['workflows'] = node['workflow-paths']
paths['activities'] = node['activity-paths']

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
