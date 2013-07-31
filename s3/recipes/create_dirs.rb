# creates directory s3_folder_dir recursively
new_dir(node['s3_folder_dir'], '0755', node['user'], node['group'])
