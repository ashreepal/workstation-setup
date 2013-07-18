require 'aws'

# get the s3 info (buckets and their files)
s3_files = node['s3-install-on-setup']

s3 = AWS::S3.new

# download and save the files
s3_files.each do |bucket_name, file_name|
  save_file = File.open("#{node['s3_folder_dir']}/#{file_name}", 'w+')
  object = s3.buckets[bucket_name].objects[file_name]
  object.read { |chunk| save_file.write(chunk) }
  save_file.close
end
