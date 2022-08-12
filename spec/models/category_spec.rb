require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando nome não for informado' do
        expect(described_class.new).to validate_presence_of(:name)
      end

      context 'uniqueness' do
        it 'inválido quando o nome já está cadastrado' do
          create(:category)

          category = described_class.new(name: 'Legumes e Verduras')

          expect(category.valid?).to be false
        end
      end
    end
  end
end
