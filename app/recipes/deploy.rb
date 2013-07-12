# use opsworks definitions for deploying code from source (git, svn, etc.) to instance
# by default, deploys to /srv/www/[app_name]/current
node[:deploy].each do |application, deploy|
  Chef::Log.info("\n\ndeploying stuff\n\n")
  deploy[:user] = 'ubuntu'
  deploy[:group] = 'ubuntu'

  opsworks_deploy_user do
    deploy_data deploy
    app application
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end
  
  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

# if deploying the app, install the gems specified by the user and run
# the code that is deployed
if node[:opsworks][:activity] == 'deploy'
  
  node['install-on-deploy'].each do |gem_info|
    g,v = gem_info
    gem_package g do
      action :nothing
      #version v
      ignore_failure true
    end.run_action(:install)
  end

  node[:deploy].each do |application, deploy|    
    bash 'run_code' do
      code "sudo ruby #{deploy[:deploy_to]}/current/run.rb"
        
      only_if do
        ::File.exists?("#{deploy[:deploy_to]}/current/run.rb")
      end
    end
  end

end
