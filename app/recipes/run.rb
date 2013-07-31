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

file_content = "require 'runner-gem'\nrun('#{node['worker_process_name']}')"

# create the runner ruby file (just requires runner-gem)
file "#{node['runner_file_dir']}" do
  mode '0755'
  owner node['user']
  group node['group']
  content file_content
  action :nothing

end.run_action(:create)

# run the code under the user id specified in the stack JSON
node[:deploy].each do |application, deploy|
  bash 'run_code' do
    code "sudo -u #{node['user']} ruby #{node['runner_file_dir']}"
      
    only_if do
      ::File.exists?("#{node['runner_file_dir']}")
    end
  end
end
