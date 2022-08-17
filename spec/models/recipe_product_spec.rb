require 'rails_helper'

RSpec.describe RecipeProduct, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'inválido quando quantidade não for informada' do
        expect(described_class.new).to validate_presence_of(:quantity)
      end
    end
  end
end
