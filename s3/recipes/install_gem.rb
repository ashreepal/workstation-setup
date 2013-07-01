require 'yaml'

s3_files = node['s3-info']

s3_files.each do |bucket,file_name|
  
  # use the gem specification to extract the gem name and version
  gem_spec = YAML.load(`gem specification #{node['s3_folder_dir']}/#{file_name} --yaml`)

  gem_name = gem_spec.name.to_s
  version = gem_spec.version.to_s

  `/usr/local/bin/gem install #{node['s3_folder_dir']}/#{file_name} -q --no-rdoc --no-ri -v "#{version}"`
end
