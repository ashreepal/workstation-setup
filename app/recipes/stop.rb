# kill the workers
`sudo -u #{node['user']} pkill -9 -f #{node['runner_file_dir']}`
