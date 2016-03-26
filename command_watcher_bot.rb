class CommandWatcherBot
  def initialize(text: text)
    @text = text
  end

  def check_all
    args = @text.split(' ')
    case args.first
    when '/start'
      'tweap bot meldet sich zum Dienst!'
    when '/help'
      '/swag is all I know xD'
    when '/swag'
      'yolo swag'
    end
  end
end
