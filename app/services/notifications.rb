class Notifications
  def self.slack!(body:, channel: 'assignments')
    Slack.configure do |config|
      config.token = 'xoxp-968938902677-1092494892740-1072265957223-ce93203ddf05f71c92cb502b78f5501b'
    end

    client = Slack::Web::Client.new
    client.chat_postMessage(channel: channel, text: body, as_user: true)
  end
end
