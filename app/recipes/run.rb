node[:deploy].each do |application, deploy|    
  bash 'run_code' do
    code "sudo ruby #{deploy[:deploy_to]}/current/run.rb"
      
    only_if do
      ::File.exists?("#{deploy[:deploy_to]}/current/run.rb")
    end
  end
end
