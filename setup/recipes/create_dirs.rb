# Creating directory for the log file

# creates all the directories into log_folder_dir recursively
log_dir = directory "#{node['log_folder_dir']}" do
  mode '0755'
  owner 'root'
  group 'root'
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['log_folder_dir'])
  end

end

log_dir.run_action(:create)
