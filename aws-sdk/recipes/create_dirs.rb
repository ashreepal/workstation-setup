# creates the directory of aws_folder_dir recursively
aws_dir = directory "#{node['aws_folder_dir']}" do
  mode '0755'
  owner 'root'
  group 'root'
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['aws_folder_dir'])
  end

end

aws_dir.run_action(:create)
