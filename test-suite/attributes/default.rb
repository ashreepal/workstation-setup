# the version of minitest-chef-handler that comes with the agent
set[:opsworks_test_suite_loader][:minitest_chef_handler][:version] = '0.6.7'
default[:opsworks][:run_cookbook_tests] = false
default[:minitest][:recipes] = ["setup::create_files","setup::create_dirs"]
