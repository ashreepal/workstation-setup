require 'yaml'

# save the config options from the node object to a new hash to be saved as a
# file on the machine
# the extra to_hash is required because the node object uses a Mash data type
config_options = {}
config_options['activity-workers'] = node['activity-workers']
config_options['activity-workers'] = config_options['activity-workers'].map { |e| e.to_hash }
 
config_options['workflow-workers'] = node['workflow-workers']
config_options['workflow-workers'] = config_options['workflow-workers'].map { |e| e.to_hash }
  
# creates the config file (which contains the config options for deployment)
new_dir(node['config_folder_dir'], '0755', node['user'], node['group'])
new_file(node['config_file_dir'], '0755', node['user'], node['group'], config_options.to_yaml, true)
