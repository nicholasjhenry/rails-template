task :cron => :environment do
  HerokuBackupTask.execute
end
