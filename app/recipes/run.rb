directory node['runner-code-location'] do
  mode '0755'
  owner node['user']
  group node['group']
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?(node['runner-code-location'])
  end

end.run_action(:create)

# create the runner.rb file (just requires runner-gem)
file "#{node['runner-code-location']}/runner.rb" do
  mode '0755'
  owner node['user']
  group node['group']
  content 'require \'runner-gem\''
  action :nothing

  only_if do
    ::File.exists?("#{node['runner-code-location']}/")
  end

end.run_action(:create)

# run the code
node[:deploy].each do |application, deploy|
  bash 'run_code' do
    code "sudo -u #{node['user']} ruby #{node['runner-code-location']}/runner.rb"
      
    only_if do
      ::File.exists?("#{node['runner-code-location']}/runner.rb")
    end
  end
end
