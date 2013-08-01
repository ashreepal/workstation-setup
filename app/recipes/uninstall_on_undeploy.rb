# uninstalling gems indicated in JSON to be removed at undeploy time
node['uninstall-on-undeploy'].each do |g|
  
  # run_action is used to ensure that the uninstallation occurs immediately
  gem_package g do
    action :nothing
  end.run_action(:remove)
end
