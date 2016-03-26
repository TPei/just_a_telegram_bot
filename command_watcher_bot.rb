class CommandWatcherBot
  def initialize(bot: bot, sender: sender, text: text, chat_id: chat_id)
    @bot = bot
    @text = text
    @chat_id = chat_id
    @sender = sender
  end

  def check_all
    args = @text.split(' ')
    case args.first
    when '/swag'
      @bot.api.send_message(chat_id: @chat_id, text: 'Yolo Swag')
    end
  end
end
