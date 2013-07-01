# setting default values for the node object

# credentials file location, to be created recursively
default['creds_folder_dir'] = '/opt/aws'
default['creds_file_dir'] = '/opt/aws/credentials.cfg'

# logfile location, to be created recursively
default['log_folder_dir'] = '/opt/temp'
default['log_file_dir'] = '/opt/temp/logfile.txt'

# aws directory, to be created recursively
default['aws_folder_dir'] = '/opt/aws'

# s3 location, to be created recursively
default['s3_folder_dir'] = '/opt/temp'

# default fake AWS-creds
default['AWS-creds'] = { 'access_key_id' => 'access',
                         'secret_access_key' => 'secret',
                         'region' => 'us-east-1'          }

# default fake bucket and file name to grab from s3
default['s3-info'] = { 'bucket_name' => 'bucket',
                       'file_name' => 'file'      }
