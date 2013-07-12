# use opsworks definitions for deploying code from source (git, svn, etc.) to instance
# by default, deploys to /srv/www/[app_name]/current
require 'yaml'

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

if node[:opsworks][:activity] == 'deploy'
  Chef::Log.info("\nmachine set up, so running deploy code\n")

  node['install-on-deploy'].each do |gem_info|
    g,v = gem_info
    gem_package g do
      action :nothing
#      version v
      ignore_failure true
    end.run_action(:install)
  end

  Chef::Log.info("node object looks like: \n")
  Chef::Log.info("#{node.to_yaml}\n")
  if File.exists?("#{node[:deploy][:deploy_to]}/current/run.rb")
    Chef::Log.info("\n\nFILE EXISTS: #{node[:deploy][:deploy_to]}/current/run.rb")
    `sudo ruby #{node[:deploy][:deploy_to]}/current/run.rb`
    Chef::Log.info("\n\nEXECUTED THE SUDO RUBY COMMAND")
  end
else
  Chef::Log.info("not yet set up, so will not run anything")
end
