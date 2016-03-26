class QualityAssuranceBot
  FORBIDDEN_WORDS = ['penner', 'fotze', 'huso', 'spast', 'penis', 'homo', 'kanacke', 'mongo', 'php']
  NICE_WORDS = ['domain driven design', 'milena', 'cqrs', 'algorithmus']

  def initialize(bot: bot, sender: sender, text: text, chat_id: chat_id)
    @bot = bot
    @text = text
    @chat_id = chat_id
    @sender_name = "#{sender.first_name}"
  end

  def check_all
    watch_swear_words || watch_eloquency
  end

  private

  def watch_swear_words
    FORBIDDEN_WORDS.each do |word|
      if @text.downcase.include? word
        @bot.api.send_message(chat_id: @chat_id, text: "Hey #{@sender_name}, sag nicht sowas ungehöriges")
        return true
      end
    end
    false
  end

  def watch_eloquency
    NICE_WORDS.each do |word|
      if @text.downcase.include? word
        @bot.api.send_message(chat_id: @chat_id, text: "Hey #{@sender_name}, solch schöne Worte")
        return true
      end
    end
    false
  end
end
