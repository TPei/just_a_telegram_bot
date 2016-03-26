require 'telegram/bot'
require 'dotenv'
require './quality_assurance_bot'
require './command_watcher_bot'
require './commenter_bot'
require './message_dispatcher'
Dotenv.load

token = ENV['BOT_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    if message.text
      responses = []
      chat_id = message.chat.id

      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "tweap bot meldet sich zum Dienst!")
      when '/help'
        bot.api.send_message(chat_id: message.chat.id, text: "/swag is all I know xD")
      end

      if message.text.start_with? '/'
        responses.push CommandWatcherBot.new(text: message.text).check_all
      end

      responses.push CommenterBot.new(text: message.text).check_all
      responses.push QualityAssuranceBot.new(sender: message.from, text: message.text).check_all

      mdp = MessageDispatcher.new(bot: bot, chat_id: chat_id)
      mdp.dispatch_batch(responses)
    end
  end
end
