# use opsworks definitions for deploying code from source (git, svn, etc.) to instance
# by default, deploys to /srv/www/[app_name]/current
if node['machine-set-up']
  Chef::Log.info("\nmachine set up, so running deploy code\n")
  node[:deploy].each do |application, deploy|
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

  node['install-on-deploy'].each do |gem_info|
    g,v = gem_info
    gem_package g do
      action :nothing
#      version v
      ignore_failure true
    end.run_action(:install)
  end

  node[:deploy].each do |application, deploy|
    if File.exists?("#{deploy[:deploy_to]}/current/run.rb")
      Chef::Log.info("\n\nFILE EXISTS: #{deploy[:deploy_to]}/current/run.rb")
      `sudo ruby #{deploy[:deploy_to]}/current/run.rb`
      Chef::Log.info("\n\nEXECUTED THE SUDO RUBY COMMAND")
    end
  end
else
  Chef::Log.info("not yet set up, so will not deploy")
end
