# Creating directories for the log file and credentials file

# creates all the directories into creds_folder_dir recursively
node[:creds_folder_dir].each do |dir|
  creds_dir = directory "#{dir}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :nothing
    recursive true
    
    # skip this step if the directory already exists
    not_if do
      ::File.exists?(node[:creds_folder_dir].last)
    end

  end

  # ensure that this happens immediately
  creds_dir.run_action(:create)

end


# creates all the directories into log_folder_dir recursively
node[:log_folder_dir].each do |dir|
  log_dir = directory "#{dir}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :nothing
    recursive true
    
    # skip this step if the directory already exists
    not_if do
      ::File.exists?(node[:log_folder_dir].last)
    end

  end

  # ensure that this happens immediately
  log_dir.run_action(:create)
  
end
