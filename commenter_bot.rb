class CommenterBot
  COMMENTS = {
    'how about no' => 'http://thomaspeikert.de/hanb',
    'you got me' => 'walter white link'
  }.freeze

  def initialize(text: text)
    @text = text
  end

  def check_all
    COMMENTS.each do |key, value|
      if @text.downcase.include? key
        return value
      end
    end
    nil
  end
end
