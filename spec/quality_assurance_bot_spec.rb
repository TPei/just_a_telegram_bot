require './quality_assurance_bot'

RSpec.describe CommenterBot do
  before do
    @sender = double
    allow(@sender).to receive(:first_name).and_return 'tpei'
  end

  it 'watches our language for bad words' do
    bad_words = QualityAssuranceBot::FORBIDDEN_WORDS
    bad_words.each do |word|
      qab = QualityAssuranceBot.new(sender: @sender, text: "Hey #{word}")
      expect(qab.check_all).to eq 'Hey tpei, sag nicht so etwas'
    end
  end

  it 'watches our language for good words' do
    good_words = QualityAssuranceBot::NICE_WORDS
    good_words.each do |word|
      qab = QualityAssuranceBot.new(sender: @sender, text: "Hey #{word}")
      expect(qab.check_all).to eq 'Hey tpei, solch schoene Worte'
    end
  end

  it 'only reacts to bad words if there are good and bad words' do
    bad_words = QualityAssuranceBot::FORBIDDEN_WORDS
    good_words = QualityAssuranceBot::NICE_WORDS

    qab = QualityAssuranceBot
          .new(sender: @sender,
               text: "Hey, #{bad_words.sample}, #{good_words.sample}")
    expect(qab.check_all).to eq 'Hey tpei, sag nicht so etwas'
  end
end
