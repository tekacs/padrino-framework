def setup_script
  copy_file('templates/scripts/right.js', destination_root("/public/javascripts/right.js"))
  create_file(destination_root('/public/javascripts/application.js'), "// Put your application scripts here")
end
