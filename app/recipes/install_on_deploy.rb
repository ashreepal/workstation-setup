# install gems indicated in JSON to be installed at deploy time
node['install-on-deploy'].each do |gem_info|
  g,v = gem_info
  gem_package g do
    action :nothing
    #version v
    ignore_failure true
  end.run_action(:install)
end
