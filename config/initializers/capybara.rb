Capybara.register_driver(:headless_chrome) do |app|
  user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: (%w[ headless disable-gpu hide-scrollbars ] << "--user-agent='#{user_agent}'") }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :headless_chrome
Capybara.ignore_hidden_elements = false

# Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3
