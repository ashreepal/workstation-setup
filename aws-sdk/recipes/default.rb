# included in this order to ensure that directories are created
# before the installation of the aws-sdk gem
include_recipe 'aws-sdk::create_dirs'
include_recipe 'aws-sdk::install_gem'
