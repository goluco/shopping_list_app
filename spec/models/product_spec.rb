require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando nome não for informado' do
        expect(described_class.new).to validate_presence_of(:name)
      end

      it 'inválido quando categoria não for informada' do
        expect(described_class.new).to validate_presence_of(:category)
      end

      it 'inválido quando o usuário não for informado' do
        expect(described_class.new).to validate_presence_of(:user)
      end
    end
  end
end
