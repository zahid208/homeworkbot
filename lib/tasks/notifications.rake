namespace :test do
  desc 'Test Notifications'
  task notifications: :environment do
    Notifications.slack!(body: "Test Notification")
  end
end

##-- Start
  # 1. bundle exec rake automate:bidding RAILS_ENV=production --trace 2>&1 >> log/rake.log &

##--- Stop
  # 1. ps ax | grep ruby
  # 2. kill -9 [pid]
