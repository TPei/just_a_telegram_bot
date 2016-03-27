class CommenterBot
  COMMENTS = {
    'how about no' => 'http://i.imgur.com/zxl58Pv.jpg?1',
    'you got me' => 'http://i.imgur.com/jvsIqgz.gifv',
    'very wow' => 'https://imgflip.com/s/meme/Doge.jpg'
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
