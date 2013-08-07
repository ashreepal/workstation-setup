# indicates which packages will be installed based on the platform
packages = value_for_platform(
    ["centos", "redhat", "fedora"] =>
      { "default" => [] },
    ["debian", "ubuntu"] =>
      {"default" => ["ruby-dev", "rubygems"] },
    "default" => []
)

# installing the packages
packages.each do |pkg|
  
  # run_action is used to ensure that the installation occurs immediately
  package pkg do
    action :nothing
  end.run_action(:install)
end

# installs the gem for the aws sdk, and using run_action forces the
# execution to occur immediately (to preserve a specific execution order)
gem_package 'aws-sdk' do
  action :nothing
  version node['aws-sdk-version']
end.run_action(:install)
