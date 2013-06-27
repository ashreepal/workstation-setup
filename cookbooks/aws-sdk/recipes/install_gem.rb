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
  aws_pkg = package pkg do
    action :nothing
  end

  aws_pkg.run_action(:install)

end

# installs the gem for the aws sdk (no attributes, and default action is
# install when none is indicated)
aws_gem = gem_package "aws-sdk" do
  action :nothing
end

aws_gem.run_action(:install)
