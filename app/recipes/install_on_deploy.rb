# install gems indicated in stack JSON to be installed at deploy time
node['install-on-deploy'].each do |gem_name, gem_version|

  # setting action to :nothing and using run_action(:install) forces the
  # execution order of the recipes
  gem_package gem_name do
    action :nothing
    version gem_version
  end.run_action(:install)
end
