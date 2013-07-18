require 'yaml'

# creates the log file (which contains the node object)
file node['log_file_dir'] do
  mode '0755'
  owner 'root'
  group 'root'
  content node.to_yaml
  action :nothing

  only_if do
    ::File.exists?(node['log_folder_dir'])
  end

end.run_action(:create_if_missing)
