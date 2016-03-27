class QualityAssuranceBot
  FORBIDDEN_WORDS = ['*', '**', '***'].freeze
  NICE_WORDS = ['Componentization via Services', 'Evolutionary Design'].freeze

  def initialize(sender: sender, text: text)
    @text = text
    @sender_name = "#{sender.first_name}"
  end

  def check_all
    watch_swear_words || watch_eloquency
  end

  private

  def watch_swear_words
    FORBIDDEN_WORDS.each do |word|
      if @text.downcase.include? word
        return "Hey #{@sender_name}, sag nicht sowas ungehöriges"
      end
    end
    nil
  end

  def watch_eloquency
    NICE_WORDS.each do |word|
      if @text.downcase.include? word
        return "Hey #{@sender_name}, solch schöne Worte"
      end
    end
    nil
  end
end
