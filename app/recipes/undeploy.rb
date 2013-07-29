# uninstall gems on undeploy if they should be removed
include_recipe 'app::uninstall_on_undeploy'

# kill the workers
include_recipe 'app::stop'
