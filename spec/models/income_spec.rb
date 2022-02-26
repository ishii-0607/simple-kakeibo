require 'rails_helper'

RSpec.describe 'Incomeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { income.valid? }

    let(:user) { create(:user) }
    let!(:income) { build(:income, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        income.name = ''
        is_expected.to eq false
      end
    end

    context 'valueカラム' do
      it '空欄でないこと' do
        income.value = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Costモデルとの関係' do
      it '1:1となっている' do
        expect(Income.reflect_on_association(:cost).macro).to eq :has_one
      end
    end

    context 'Userモデルとの関係' do
      it 'n:1となっている' do
        expect(Income.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
