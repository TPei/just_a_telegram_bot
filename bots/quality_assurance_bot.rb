class QualityAssuranceBot
  FORBIDDEN_WORDS = ['*', '**', '***'].freeze
  NICE_WORDS = ['componentization via services', 'evolutionary design'].freeze

  def initialize(sender:, text:)
    @text = text
    @sender_name = sender.first_name.to_s
  end

  def check_all
    watch_swear_words || watch_eloquency
  end

  private

  def watch_swear_words
    FORBIDDEN_WORDS.each do |word|
      if @text.downcase.include? word
        return "Hey #{@sender_name}, sag nicht so etwas"
      end
    end
    nil
  end

  def watch_eloquency
    NICE_WORDS.each do |word|
      if @text.downcase.include? word
        return "Hey #{@sender_name}, solch schoene Worte"
      end
    end
    nil
  end
end
