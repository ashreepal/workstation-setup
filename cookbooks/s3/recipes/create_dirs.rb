# creates all the directories into s3_folder_dir recursively
node[:s3_folder_dir].each do |dir|
  s3_dir = directory "#{dir}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :nothing
    recursive true
    
    # skip this step if the directory already exists
    not_if do
      ::File.exists?(node[:s3_folder_dir].last)
    end

  end

  # ensure that this happens immediately
  s3_dir.run_action(:create)

end
