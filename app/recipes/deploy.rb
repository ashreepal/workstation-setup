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

node['install-on-deploy'].each do |g|
  gem_package g do
    action :nothing
  end.run_action(:install)
end
