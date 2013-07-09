# use opsworks definitions for deploying code from source (git, svn, etc.) to instance
# by default, deploys to /srv/www/[app_name]/current
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

# if ruby 1.9.3 is installed, then install the gems (only after the configure stage)
Chef::Log.info("\b\bruby version is #{RUBY_VERSION}")
if RUBY_VERSION == '1.9.3'
  Chef::Log.info("\nRuby installed, so installing deploy gems\n")
  node['install-on-deploy'].each do |g|
    gem_package g do
      action :nothing
      ignore_failure true
    end.run_action(:install)
  end
else
  Chef::Log.info("\nRuby not installed, so not installing deploy gems\n")
end
