require 'json'

# create a log file containing the full node object and save it to the instance
new_file(node['log_file_dir'], '0755', node['user'], node['group'], node.to_json, false)
