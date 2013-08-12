# install any public gems as indicated by the stack JSON
node['install-on-setup'].each do |gem_name, gem_version|

  # run_action is used to ensure that the isntallation occurs immediately
  gem_package gem_name do
    version gem_version
    action :nothing
  end.run_action(:install)
end
