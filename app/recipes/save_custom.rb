require 'yaml'

custom_options = node['custom-options'].to_hash

# creates the custom file (which contains the custom variables for deployment)
custom_dir = directory "#{node['custom_folder_dir']}" do
  mode '0755'
  owner node['user']
  group node['group']
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['custom_folder_dir'])
  end

end

custom_dir.run_action(:create)

custom_file = file node['custom_file_dir'] do
  mode '0755'
  owner node['user']
  group node['group']
  content custom_options.to_yaml
  action :nothing

  only_if do
    ::File.exists?(node['custom_folder_dir'])
  end

end

custom_file.run_action(:create)
