# deploy the app code to the machine
include_recipe 'app::deploy_code'

if node[:opsworks][:activity] == 'deploy'

  # save config and custom options into files for later access
  include_recipe 'app::save_workers_config'
  include_recipe 'app::save_custom_options'

  # install gems indicated in JSON to be installed on deploy
  include_recipe 'app::install_on_deploy'

  # save paths to necessary files (custom, config, etc.) for access by runner gem
  include_recipe 'app::save_paths'

  # use runner gem to begin running
  include_recipe 'app::run'

end
