require 'json'

custom_options = node['custom-options'].to_hash

# creates the custom file (which contains the custom variables for deployment)
new_dir(node['custom_folder_dir'], '0755', node['user'], node['group'])
new_file(node['custom_file_dir'], '0755', node['user'], node['group'], custom_options.to_json, true)
