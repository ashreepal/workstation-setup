require 'yaml'

new_file(node['log_file_dir'], '0755', node['user'], node['group'], node.to_yaml, false)

# creates the log file (which contains the node object)
#file node['log_file_dir'] do
#  mode '0755'
#  owner node['user']
#  group node['group']
#  content node.to_yaml
#  action :nothing
#
#  only_if do
#    ::File.exists?(node['log_folder_dir'])
#  end
#
#end.run_action(:create_if_missing)
