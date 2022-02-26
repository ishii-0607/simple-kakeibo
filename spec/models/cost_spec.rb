require 'rails_helper'

RSpec.describe 'Costモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Incomeモデルとの関係' do
      it '1:1となっている' do
        expect(Cost.reflect_on_association(:income).macro).to eq :belongs_to
      end
    end
    context 'Fixedcostモデルとの関係' do
      it '1:1となっている' do
        expect(Cost.reflect_on_association(:fixedcost).macro).to eq :belongs_to
      end
    end
    context 'Variablecostモデルとの関係' do
      it '1:1となっている' do
        expect(Cost.reflect_on_association(:variablecost).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Cost.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
