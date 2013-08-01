# install any public gems as indicated by the stack JSON
node['install-on-setup'].each do |gem_info|
  g,v = gem_info

  # run_action is used to ensure that the isntallation occurs immediately
  gem_package g do
    version v
    action :nothing
  end.run_action(:install)
end
