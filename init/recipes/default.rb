class Chef::Recipe
  include FileHelper
end

# set up initial files and directories
include_recipe 'setup::default'

# download and install the aws-sdk
include_recipe 'aws-sdk::default'

# download and install gems from s3
include_recipe 's3::default'

# install any other gems that need to be installed
include_recipe 'gems::default'
