# setting default values for the node object

# default temporary files location
TEMP_DIR = '/opt/temp'

# logfile location, to be created recursively
default['log_folder_dir'] = TEMP_DIR
default['log_file_dir'] = "#{node['log_folder_dir']}/logfile.json"

# configfile location, for use during deployment
default['config_folder_dir'] = TEMP_DIR
default['config_file_dir'] = "#{node['config_folder_dir']}/config.json"

# customfile location, for use during deployment
default['custom_folder_dir'] = TEMP_DIR
default['custom_file_dir'] = "#{node['custom_folder_dir']}/custom.json"

# pathsfile location, used by runner code to find relevant information/parameters
default['paths_folder_dir'] = TEMP_DIR
default['paths_file_dir'] = "#{node['paths_folder_dir']}/paths.json"

# s3 downloaded files location, to be created recursively
default['s3_folder_dir'] = TEMP_DIR

# by default, no gems set to grabbed from s3
default['s3-install-on-setup'] = []

# by default, no gems set to be installed on setup
default['install-on-setup'] = []

# set the default version of the aws-sdk to nil so it automatically pulls the
# newest one by default
default['aws-sdk-version'] = nil

# set the version of ruby that will be installed
set['opsworks']['ruby_version'] = '1.9.3'
set['opsworks']['ruby_stack'] = 'ruby'

# the recipes default to using the identity that OpsWorks uses while running
# recipes, which is the root identity currently
default['user'] = `id -u -n`
default['group'] = `id -g -n` 

# set default runner location, a file that can be used to redeploy workers
# while on the instance
default['runner_folder_dir'] = '/home/runner'
default['runner_file_dir'] = "#{node['runner_folder_dir']}/runner.rb"

# default name for each worker (once the process is forked)
default['worker_process_name'] = 'aws-rf-worker'
