
# Add a User group (required)
user_group = UserGroup.create( name: 'User Group One' )

# Add the default tools;
['Plain Text','Input Box','Next Button'].each do |tool_name|
  user_group.tools.create( name: tool_name )
end

