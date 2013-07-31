require 'yaml'

new_file(node['log_file_dir'], '0755', node['user'], node['group'], node.to_yaml, false)
