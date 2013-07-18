include_recipe 'app::deploy_code'

# if deploying the app, install the gems specified by the user and run
# the code that is deployed
if node[:opsworks][:activity] == 'deploy'

  include_recipe 'app::save_config.rb'

  include_recipe 'app::save_custom.rb'

  include_recipe 'app::install_on_deploy.rb'

  include_recipe 'app::run'

end
