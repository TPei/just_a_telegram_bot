require 'telegram/bot'
require 'dotenv'
require './quality_assurance_bot'
require './command_watcher_bot'
require './commenter_bot'
Dotenv.load

token = ENV['BOT_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    chat_id = message.chat.id

    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "tweap bot meldet sich zum Dienst!")
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: "/swag is all I know xD")
    end

    if message.text.start_with? '/'
      CommandWatcherBot.new(bot: bot, sender: message.from, text: message.text, chat_id: chat_id).check_all
    end

    CommenterBot.new(bot: bot, sender: message.from, text: message.text, chat_id: chat_id).check_all
    QualityAssuranceBot.new(bot: bot, sender: message.from, text: message.text, chat_id: chat_id).check_all
  end
end
