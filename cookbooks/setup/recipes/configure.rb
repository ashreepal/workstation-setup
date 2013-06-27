# configure the AWS credentials once the aws sdk is installed and create
# credentials file
require 'aws'
require 'yaml'

creds = {}
creds[:access_key_id] = node['AWS-creds']['access_key_id']
creds[:secret_access_key] = node['AWS-creds']['secret_access_key']
creds[:region] = 'us-east-1'

# create the credentials file if it is missing
creds_file = file node[:creds_file_dir] do
  mode '0755'
  owner 'root'
  group 'root'
  content creds.to_yaml
  action :nothing

  only_if do
    ::File.exists?(node[:creds_folder_dir].last)
  end
end

creds_file.run_action(:create_if_missing)

# configure with AWS
AWS.config(creds)
