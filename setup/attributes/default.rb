# the version of minitest-chef-handler that comes with the agent
default[:minitest][:recipes] = ["setup::create_files","setup::create_dirs"]
default[:opsworks][:run_cookbook_tests] = true
