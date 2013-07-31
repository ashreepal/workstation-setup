new_dir(node['log_folder_dir'], '0755', node['user'], node['group'])

# Creating directory for the log file
#directory "#{node['log_folder_dir']}" do
#  mode '0755'
#  owner node['user']
#  group node['group']
#  action :nothing
#  recursive true
#  
#  not_if do
#    ::File.exists?(node['log_folder_dir'])
#  end
#
#end.run_action(:create)
