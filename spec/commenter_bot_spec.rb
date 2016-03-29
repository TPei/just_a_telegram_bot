require './commenter_bot'

RSpec.describe CommenterBot do
  it 'knows all the things in the comments hash' do
    comments = CommenterBot::COMMENTS

    comments.each do |k, v|
      cb = CommenterBot.new(text: k)
      expect(cb.check_all).to eq v
    end
  end
end
