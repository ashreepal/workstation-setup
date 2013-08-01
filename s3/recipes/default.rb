# first, create the directory to save the s3 gems, then get the gems and
# install them
include_recipe 's3::create_dirs'
include_recipe 's3::get'
include_recipe 's3::install_gem'
