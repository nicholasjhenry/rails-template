load_pattern 'config/database.yml'
gsub_file 'config/database.yml', /APP_NAME/, app_name
