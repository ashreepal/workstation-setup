require 'aws'

# get the name of the file and the bucket it's in to get it from S3
bucket_name = node['s3-info']['bucket_name']
file_name = node['s3-info']['file_name']

s3 = AWS::S3.new

# save the file
save_file = File.open("#{node[:s3_folder_dir]}/#{file_name}", 'w+')
object = s3.buckets[bucket_name].objects[file_name]
object.read do |chunk|
  save_file.write(chunk)
end
save_file.close
