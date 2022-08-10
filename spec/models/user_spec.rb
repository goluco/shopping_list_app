require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando nome não for informado' do
        expect(described_class.new).to validate_presence_of(:name)
      end

      it 'inválido quando email não for informado' do
        expect(described_class.new).to validate_presence_of(:email)
      end

      it 'inválido quando senha não for informado' do
        expect(described_class.new).to validate_presence_of(:password)
      end
    end
  end
end
