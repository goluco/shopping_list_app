require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando nome não for informado' do
        expect(described_class.new).to validate_presence_of(:name)
      end

      it 'inválido quando não há usuário registrado' do
        expect(described_class.new).to validate_presence_of(:user)
      end
    end
  end
end
