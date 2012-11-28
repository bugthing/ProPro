
# Add a User group (required)
UserGroup.create( name: 'User Group One' )

# Add the default tools;
['Plain Text','Input Box','Next Button'].each do |tool_name|
  Tool.create( name: tool_name )
end

