node[:deploy].each do |application, deploy|
  deploy[:user] = 'ubuntu'
  deploy[:group] = 'ubuntu'

#  directory "/srv/www/#{application}/shared/cached-copy" do
#    owner 'root'
#    group 'root'
#    action :nothing
#    recursive true
#  end.run_action(:create)
  
  
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
