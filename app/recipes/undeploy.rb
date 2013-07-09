# uninstall gems on undeploy if they should be removed
Chef::Log.info("\nuninstalling on undeploy\n") 
node['uninstall-on-undeploy'].each do |g|
  gem_package g do
    action :nothing
    ignore_failure true
  end.run_action(:remove)
end
