# create a directory in which the gems pulled from s3 can be stored
new_dir(node['s3_folder_dir'], '0755', node['user'], node['group'])
