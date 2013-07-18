# uninstalling gems indicated in JSON to be removed at undeploy time
node['uninstall-on-undeploy'].each do |g|
  gem_package g do
    action :nothing
    ignore_failure true
  end.run_action(:remove)
end
