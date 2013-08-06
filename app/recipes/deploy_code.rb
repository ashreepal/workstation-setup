# Use opsworks definitions for deploying code from source (git, svn, etc.) to
# instance. Your code deploys to /srv/www/[app_name]/current.
# You can specify the location of the runner file, which can be used to
# re-deploy workers, but your workflow code will always be stored in this
# location.
node[:deploy].each do |application, deploy_settings|

  opsworks_deploy_user do
    deploy_data deploy_settings
    app application
  end

  opsworks_deploy_dir do
    user deploy_settings[:user]
    group deploy_settings[:group]
    path deploy_settings[:deploy_to]
  end
  
  opsworks_deploy do
    deploy_data deploy_settings
    app application
  end
end
