class CommenterBot
  COMMENTS = {
    'how about no' => 'http://thomaspeikert.de/hanb',
    'you got me' => 'walter white link'
  }.freeze

  def initialize(bot: bot, sender: sender, text: text, chat_id: chat_id)
    @bot = bot
    @text = text
    @chat_id = chat_id
    @sender_name = "#{sender.first_name}"
  end

  def check_all
    COMMENTS.each do |key, value|
      if @text.downcase.include? key
        @bot.api.send_message(chat_id: @chat_id, text: value)
        return
      end
    end
  end
end
