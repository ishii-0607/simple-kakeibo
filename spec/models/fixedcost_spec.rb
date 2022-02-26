require 'rails_helper'

RSpec.describe 'Fixedcostモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { fixedcost.valid? }

    let(:user) { create(:user) }
    let!(:fixedcost) { build(:fixedcost, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        fixedcost.name = ''
        is_expected.to eq false
      end
    end
    context 'valueカラム' do
      it '空欄でないこと' do
        fixedcost.value = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Costモデルとの関係' do
      it '1:1となっている' do
        expect(Fixedcost.reflect_on_association(:cost).macro).to eq :has_one
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Fixedcost.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
