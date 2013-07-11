# setting default values for the node object

# logfile location, to be created recursively
default['log_folder_dir'] = '/opt/temp'
default['log_file_dir'] = '/opt/temp/logfile.txt'

# aws directory, to be created recursively
default['aws_folder_dir'] = '/opt/aws'

# s3 downloaded files ocation, to be created recursively
default['s3_folder_dir'] = '/opt/temp'

# default fake bucket and file name to grab from s3
default['s3-install-on-setup'] = []

# by default, no gems set to be installed on setup
default['install-on-setup'] = []

# set the default version of the aws-sdk to nil so it automatically pulls the
# newest one
default['aws-sdk-version'] = nil

# set the version of ruby that will be installed
set['opsworks']['ruby_version'] = '1.9.3'
set['opsworks']['ruby_stack'] = 'ruby'
