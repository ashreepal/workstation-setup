require 'aws'

# get the name of the files and their bucket to get it from S3

s3_files = node['s3-info']

s3 = AWS::S3.new

# save the files
s3_files.each do |bucket_name, file_name|
  save_file = File.open("#{node['s3_folder_dir']}/#{file_name}", 'w+')
  object = s3.buckets[bucket_name].objects[file_name]
  object.read do |chunk|
    save_file.write(chunk)
  end
  save_file.close
end
