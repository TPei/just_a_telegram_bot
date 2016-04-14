require './bots/translation_bot'

RSpec.describe TranslationBot do
  # rubocop:disable all
  it 'recognizes a language and then translates' do
    tb = TranslationBot.new('Evaluando el Patron de Arquitecture Monolitica y de Micro Servicios Para Desplegar Aplicaciones en la Nube')
    expect(tb.translate).to eq 'Evaluating the Pattern of Architecture Monolithic and Micro Services To Deploy Applications in the Cloud'
  end
  # rubocop:enable all
end
