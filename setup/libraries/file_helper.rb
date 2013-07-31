#module FileHelper
#  def new_dir(dir, mode, user, group)
#    new_dir = directory dir do
#      mode mode
#      owner user
#      group group
#      action :nothing
#      recursive true
#  
#      not_if do
#        ::File.exists?(dir)
#      end
#    end
#    
#    new_dir.run_action(:create)
#  end
#  
#  def new_file(dir, mode, user, group, content = nil, overwrite = false)
#    new_file = file dir do
#      mode mode
#      owner user
#      group group
#      action :nothing
#      content content
#  
#    end
#    
#    if overwrite
#      new_file.run_action(:create)
#    else
#      new_file.run_action(:create_if_missing)
#    end
#  end
#end
#
#class Chef::Recipe
#  include FileHelper
#end
