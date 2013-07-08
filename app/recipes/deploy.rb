node[:deploy].each do |application, deploy|
  deploy[:user] = 'ubuntu'
  deploy[:group] = 'ubuntu'
  
  opsworks_deploy do
    deploy_data deploy
    app application
  end
end
