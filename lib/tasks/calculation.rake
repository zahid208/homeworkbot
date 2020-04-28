namespace :automate do
  desc 'Calculate Balance'
  task :calculation, [:account_id, :page] => :environment do |t, args|
    account = Account.find(args.account_id)
    session = Capybara::Session.new(:headless_chrome)

    session.visit 'https://www.homeworkmarket.com/student-auth-wizard?authOption=sign-in'
    session.find('#username').set(account.email)
    session.find('#password').set(account.password)
    session.find('.btn-submit').click

    if session.has_css?(".items-list li", wait: 10)
      session.visit 'https://www.homeworkmarket.com/teacher/funds/balance'
      if session.has_css?(".hwmkt-table", wait: 10)
        page = args.page.present? ? args.page.to_i : 1
        loop do
          account.update_column :last_calculated_page, page

          if session.has_css?(".c1-t-body .no-results", wait: 10)
            puts "No more records"
            break
          end

          session.all('.c1-t-body .c1-tr').each do |row|
            if session.has_css?(".date-column time", wait: 10)
              datetime = row.find('.date-column time')[:datetime].to_datetime
              transaction = account.transactions.find_or_initialize_by(string_time_key: "#{row.find('.date-column time')[:datetime]}-#{row.find('.payment-id-column a').text}")

              transaction.attributes = {
                processed_at: datetime,
                payment_id: row.find('.payment-id-column a').text,
                reference_link: (row.has_css?('.item-column a') ? row.find('.item-column a')[:href] : ''),
                event: row.find('.event-column span').text,
                amount: row.find('.amount-column span').text.to_f,
                change: row.find('.change-column span').text.to_f,
                balance: row.find('.balance-column span').text.to_f,
              }

              if transaction.new_record?
                puts "created a new record: #{datetime} - #{transaction.payment_id}"
              else
                puts "Updated previous record: #{datetime} - #{transaction.payment_id}"
              end
              transaction.save
            else
              page -= 1
              puts "Records not found"
            end
          end

          page += 1
          session.visit "https://www.homeworkmarket.com/teacher/funds/balance?page=#{page}"
        end
      end
    end
  end
end

##-- Start
  # 1. bundle exec rake automate:bidding RAILS_ENV=production --trace 2>&1 >> log/rake.log &

##--- Stop
  # 1. ps ax | grep ruby
  # 2. kill -9 [pid]
