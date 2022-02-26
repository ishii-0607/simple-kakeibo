require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
    end
    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Costモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:costs).macro).to eq :has_many
      end
    end
    context 'Incomeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:incomes).macro).to eq :has_many
      end
    end
    context 'Fixedcostモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:fixedcosts).macro).to eq :has_many
      end
    end
    context 'Variablecostモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:variablecosts).macro).to eq :has_many
      end
    end
  end
end
