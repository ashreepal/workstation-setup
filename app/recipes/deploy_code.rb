# use opsworks definitions for deploying code from source (git, svn, etc.) to instance
# by default, deploys to /srv/www/[app_name]/current
require 'yaml'

node[:deploy].each do |application, deploy|
  Chef::Log.info("\n\ndeploying stuff\n\n")
  Chef::Log.info("\n\n\n\n\n\n#{node.to_yaml}\n\n\n\n\n\n")
  deploy[:user] = 'root'
  deploy[:group] = 'root'

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
