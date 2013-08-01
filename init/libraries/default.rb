module FileHelper
  def new_dir(dir, mode, user, group)
    
    # the mode sets rwx permissions
    # the action :nothing then immediate run_action ensures that the directory
    # creation will occur immediately
    new_dir = directory dir do
      mode mode
      owner user
      group group
      action :nothing
      recursive true
  
      not_if do
        ::File.exists?(dir)
      end
    end
    
    new_dir.run_action(:create)
  end
  
  def new_file(dir, mode, user, group, content = nil, overwrite = false)
    
    # the mode sets rwx permissions
    # the action :nothing then immediate run_action ensures that the directory
    # creation will occur immediately
    # overwrite indicates whether or not the file should be overwritten if it
    # already exists, or if it should be left alone
    new_file = file dir do
      mode mode
      owner user
      group group
      action :nothing
      content content
  
    end
    
    if overwrite
      new_file.run_action(:create)
    else
      new_file.run_action(:create_if_missing)
    end
  end
end

# make the class accessible to all recipes that are either in this cookbook
# or that 'depends' this cookbook in their metadata.rb file
class Chef::Recipe
  include FileHelper
end
