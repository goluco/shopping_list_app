require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'inválido quando o nome não for informado' do
        expect(described_class.new).to validate_presence_of(:name)
      end

      it 'inválido quando o número de pessoas não for informado' do
        expect(described_class.new).to validate_presence_of(:people)
      end
    end
  end
end
