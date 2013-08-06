# create a folder in which the runner starter file will be created
new_dir(node['runner_folder_dir'], '0755', node['user'], node['group'])

# the file, once run, will require the gem and call its run function
file_content = "require 'runner-gem'\nrun('#{node['worker_process_name']}')"

# create the runner ruby file
new_file(node['runner_file_dir'], '0755', node['user'], node['group'], file_content, true)

# run the code under the user id specified in the stack JSON
bash 'run_code' do
  code "sudo -u #{node['user']} ruby #{node['runner_file_dir']}"
    
  only_if do
    ::File.exists?("#{node['runner_file_dir']}")
  end
end
