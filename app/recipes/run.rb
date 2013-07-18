file '/home/ubuntu/runner.rb' do
  mode '0755'
  owner 'root'
  group 'root'
  content 'require \'runner-gem\''
  action :nothing

  only_if do
    ::File.exists?('/home/ubuntu/')
  end

end.run_action(:create)

node[:deploy].each do |application, deploy|    
  bash 'run_code' do
    code "sudo ruby /home/ubuntu/runner.rb"
      
    only_if do
      ::File.exists?("/home/ubuntu/runner.rb")
    end
  end
end
