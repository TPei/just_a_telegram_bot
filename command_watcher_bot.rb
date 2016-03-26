class CommandWatcherBot
  def initialize(text: text)
    @text = text
  end

  def check_all
    args = @text.split(' ')
    case args.first
    when '/swag'
      return 'yolo swag'
    end
    nil
  end
end
