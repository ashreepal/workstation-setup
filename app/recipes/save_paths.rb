require 'json'

# records path to important files that will need to be accessed by the runner
# file when it is run and workers are deployed
paths = {}
paths['config'] = node['config_file_dir']
paths['custom'] = node['custom_file_dir']

node[:deploy].each do |application, deploy_settings|
  paths['workflows'] = node['workflow-paths'].map do |p|
    "#{deploy_settings[:deploy_to]}/current/#{p}"
  end
  paths['activities'] = node['activity-paths'].map do |p|
    "#{deploy_settings[:deploy_to]}/current/#{p}"
  end
end

# creates the file
new_dir(node['paths_folder_dir'], '0755', node['user'], node['group'])
new_file(node['paths_file_dir'], '0755', node['user'], node['group'], paths.to_json, true)
