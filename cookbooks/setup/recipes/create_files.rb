require 'yaml'

# creates the log file
log_file = file node[:log_file_dir] do
  mode '0755'
  owner 'root'
  group 'root'
  content 'log'
  action :nothing

  only_if do
    ::File.exists?(node[:log_folder_dir].last)
  end
end

log_file.run_action(:create_if_missing)
