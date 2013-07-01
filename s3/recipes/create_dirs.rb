# creates directory s3_folder_dir recursively
s3_dir = directory "#{node['s3_folder_dir']}" do
  mode '0755'
  owner 'root'
  group 'root'
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['s3_folder_dir'])
  end

end

s3_dir.run_action(:create)
