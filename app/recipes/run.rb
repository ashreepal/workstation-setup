directory '/home/runner' do
  mode '0755'
  owner 'root'
  group 'root'
  action :nothing
  recursive true
  
  not_if do
    ::File.exists?('/home/runner')
  end

end.run_action(:create)

# create the runner.rb file (just requires runner-gem)
file '/home/runner/runner.rb' do
  mode '0755'
  owner 'root'
  group 'root'
  content 'require \'runner-gem\''
  action :nothing

  only_if do
    ::File.exists?('/home/runner/')
  end

end.run_action(:create)

# run the code
node[:deploy].each do |application, deploy|
  bash 'run_code' do
    code "sudo ruby /home/runner/runner.rb"
      
    only_if do
      ::File.exists?("/home/runner/runner.rb")
    end
  end
end
