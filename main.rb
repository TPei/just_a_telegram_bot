require 'telegram/bot'
require 'dotenv'
require './quality_assurance_bot'
require './command_watcher_bot'
Dotenv.load

token = ENV['BOT_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    chat_id = message.chat.id

    if message.text.start_with? '/'
      CommandWatcherBot.new(bot: bot, sender: message.from, text: message.text, chat_id: chat_id).check_all
    end

    QualityAssuranceBot.new(bot: bot, sender: message.from, text: message.text, chat_id: chat_id).check_all
  end
end
