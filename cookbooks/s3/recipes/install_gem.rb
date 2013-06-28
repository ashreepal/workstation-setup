s3_files = node['s3-info']


s3_files.each do |bucket,file_name|
  # remove the gem name from the file name (remove the version number and ".gem"
  # from the end of the name)
  gem_name = /-[\d*\.]+\.gem$/.match(file_name).pre_match
  version = /[\d+\.]+\d/.match(/-[\d*\.]+\.gem$/.match(file_name).to_s).to_s

  `/usr/local/bin/gem install /opt/temp/#{file_name} -q --no-rdoc --no-ri -v "#{version}"`
end
