# creates the directory of aws_folder_dir recursively
new_dir(node['aws_folder_dir'], '0755', node['user'], node['group'])
