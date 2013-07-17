# install any public gems as directed through JSON
node['install-on-setup'].each do |gem_info|
  g,v = gem_info
  gem_package g do
    ignore_failure true
#    version v
    action :nothing
  end.run_action(:install)
end
