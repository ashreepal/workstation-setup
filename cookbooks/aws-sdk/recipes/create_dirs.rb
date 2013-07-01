# creates all the directories into aws_folder_dir recursively
aws_dir = directory "#{node['aws_folder_dir']}" do
  mode '0755'
  owner 'root'
  group 'root'
  action :nothing
  recursive true
  
  # skip this step if the directory already exists
  not_if do
    ::File.exists?(node['aws_folder_dir'])
  end

end

# ensure that this happens immediately
aws_dir.run_action(:create)
