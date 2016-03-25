require 'telegram/bot'
require 'dotenv'
Dotenv.load

token = ENV['BOT_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/swag'
      bot.api.send_message(chat_id: message.chat.id,
                           text: 'swag')
    end
  end
end
