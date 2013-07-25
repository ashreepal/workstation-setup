# creates directory s3_folder_dir recursively
directory "#{node['s3_folder_dir']}" do
  mode '0755'
  owner node['user']
  group node['group']
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['s3_folder_dir'])
  end

end.run_action(:create)
