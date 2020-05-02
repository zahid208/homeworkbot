namespace :automate do
  desc 'Grab hotwire confirmation code'
  task :bidding, [:account_id] => :environment do |t, args|
    puts "sdfsdf", args.inspect
    account = Account.find(args.account_id)
    session = Capybara::Session.new(:headless_chrome)
    account.update(pid: Process.pid)
    filters = account.filters

    session.visit 'https://www.homeworkmarket.com/student-auth-wizard?authOption=sign-in'
    session.find('#username').set(account.email)
    session.find('#password').set(account.password)
    session.find('.btn-submit').click

    loop do
      if session.has_css?(".items-list li", wait: 10)
        puts "Creating assignments"
        assignments = []

        session.all('.items-list li').each do |li|
          if li.has_css?("h3 a")
            puts li.find('h3 a').text
            assignment = CreateAssignment.call(li, account)
            assignments << assignment
            puts assignment.slug
          end
        end

        puts "Placing Bids"
        assignments.each do |assignment|
          PlaceBid.call(session, assignment) if assignment.can_bid? && assignment.passed?(filters)
          puts "Bid Plcaed = #{assignment.bid?}"
        end
      end

      if session.has_xpath?('//*[@id="header"]/div/div[1]/div[2]/ul/li[1]/div/div/div/a/span[2]')
        notifications = session.first('.activities .total-unread-message-count', minimum: 1).text.to_i
        Notifications.slack!(body: "#{account.title} notification Total: #{notifications}", channel: account.channel)  if notifications > account.notifications
        account.update(notifications: notifications) unless notifications == account.notifications
        puts "Total notifications: #{notifications}"
      end
      sleep(rand(10))

      session.visit('https://www.homeworkmarket.com')
      filters.reload
    end
  end
end

##-- Start
  # 1. bundle exec rake automate:bidding RAILS_ENV=production --trace 2>&1 >> log/rake.log &

##--- Stop
  # 1. ps ax | grep ruby
  # 2. kill -9 [pid]
