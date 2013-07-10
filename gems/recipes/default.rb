# install any public gems as directed through JSON

node['install-on-setup'].each do |g|
  gem_package g do
    ignore_failure true
    action :nothing
  end.run_action(:install)
end
