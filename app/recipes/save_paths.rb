require 'yaml'

# records path to important files that will need to be accessed by the runner later
paths = {}
paths['config'] = node['config_file_dir']
paths['custom'] = node['custom_file_dir']

node[:deploy].each do |application, deploy_settings|
  paths['workflows'] = node['workflow-paths'].map { |p| "#{deploy_settings[:deploy_to]}/current/#{p}" }
  paths['activities'] = node['activity-paths'].map { |p| "#{deploy_settings[:deploy_to]}/current/#{p}" }
end

# creates the file
new_dir(node['paths_folder_dir'], '0755', node['user'], node['group'])
new_file(node['paths_file_dir'], '0755', node['user'], node['group'], paths.to_yaml, true)
