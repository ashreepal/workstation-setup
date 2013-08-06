# for each gem that was downloaded from s3, install the gem using the downloaded
# file

s3_files = node['s3-install-on-setup']

s3_files.each do |_,file_name|
  # gem install each gem from s3
  `/usr/local/bin/gem install #{node['s3_folder_dir']}/#{file_name} --no-rdoc --no-ri`
end
