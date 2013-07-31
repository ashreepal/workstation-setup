# install gems indicated in stack JSON to be installed at deploy time
node['install-on-deploy'].each do |gem_info|
  g,v = gem_info

  # setting action to :nothing and using run_action(:install) ensures that
  # the gem will be installed immediately
  gem_package g do
    action :nothing
    version v
  end.run_action(:install)
end
