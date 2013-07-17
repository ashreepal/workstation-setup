require 'yaml'

# use opsworks definitions for deploying code from source (git, svn, etc.) to instance
# by default, deploys to /srv/www/[app_name]/current
node[:deploy].each do |application, deploy|
  Chef::Log.info("\n\ndeploying stuff\n\n")
  deploy[:user] = 'ubuntu'
  deploy[:group] = 'ubuntu'

  opsworks_deploy_user do
    deploy_data deploy
    app application
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end
  
  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

# if deploying the app, install the gems specified by the user and run
# the code that is deployed
if node[:opsworks][:activity] == 'deploy'

  config_options = {}
  config_options['activity-workers'] = node['activity-workers']
  config_options['activity-workers'] = config_options['activity-workers'].map { |e| e.to_hash }
  
  config_options['workflow-workers'] = node['workflow-workers']
  config_options['workflow-workers'] = config_options['workflow-workers'].map { |e| e.to_hash }
  
  custom_options = node['custom-options'].to_hash

  # creates the config file (which contains the config options for deployment)
  config_dir = directory "#{node['config_folder_dir']}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :nothing
    recursive true
    
    not_if do
      ::File.exists?(node['config_folder_dir'])
    end
  
  end
  
  config_dir.run_action(:create)
  
  config_file = file node['config_file_dir'] do
    mode '0755'
    owner 'root'
    group 'root'
    content config_options.to_yaml
    action :nothing
  
    only_if do
      ::File.exists?(node['config_folder_dir'])
    end
  
  end
  
  config_file.run_action(:create)

  # creates the custom file (which contains the custom variables for deployment)
  custom_dir = directory "#{node['custom_folder_dir']}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :nothing
    recursive true
    
    not_if do
      ::File.exists?(node['custom_folder_dir'])
    end
  
  end
  
  custom_dir.run_action(:create)
  
  custom_file = file node['custom_file_dir'] do
    mode '0755'
    owner 'root'
    group 'root'
    content custom_options.to_yaml
    action :nothing
  
    only_if do
      ::File.exists?(node['custom_folder_dir'])
    end
  
  end
  
  custom_file.run_action(:create)
  
  node['install-on-deploy'].each do |gem_info|
    g,v = gem_info
    gem_package g do
      action :nothing
      #version v
      ignore_failure true
    end.run_action(:install)
  end

  node[:deploy].each do |application, deploy|    
    bash 'run_code' do
      code "sudo ruby #{deploy[:deploy_to]}/current/run.rb"
        
      only_if do
        ::File.exists?("#{deploy[:deploy_to]}/current/run.rb")
      end
    end
  end

end
