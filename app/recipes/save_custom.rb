require 'yaml'

custom_options = node['custom-options'].to_hash

# creates the custom file (which contains the custom variables for deployment)
directory "#{node['custom_folder_dir']}" do
  mode '0755'
  owner node['user']
  group node['group']
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['custom_folder_dir'])
  end

end.run_action(:create)

file node['custom_file_dir'] do
  mode '0755'
  owner node['user']
  group node['group']
  content custom_options.to_yaml
  action :nothing

end.run_action(:create)
