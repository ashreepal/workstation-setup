directory node['runner_folder_dir'] do
  mode '0755'
  owner node['user']
  group node['group']
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['runner_folder_dir'])
  end

end.run_action(:create)

# create the runner ruby file (just requires runner-gem)
file "#{node['runner_file_dir']}" do
  mode '0755'
  owner node['user']
  group node['group']
  content 'require \'runner-gem\''
  action :nothing

  only_if do
    ::File.exists?("#{node['runner_folder_dir']}")
  end

end.run_action(:create)

# run the code
node[:deploy].each do |application, deploy|
  bash 'run_code' do
    code "sudo -u #{node['user']} ruby #{node['runner_file_dir']}"
      
    only_if do
      ::File.exists?("#{node['runner_file_dir']}")
    end
  end
end
