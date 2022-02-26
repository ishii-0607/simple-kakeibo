require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:income) { create(:income, user: user) }
  let!(:other_income) { create(:income) }
  let!(:fixedcost) { create(:fixedcost, user: user) }
  let!(:other_fixedcost) { create(:fixedcost) }
  let!(:variablecost) { create(:variablecost, user: user) }
  let!(:other_variablecost) { create(:variablecost) }
  let!(:cost) { create(:cost, user: user, income_id: income.id, fixedcost_id: fixedcost.id, variablecost_id: variablecost.id) }
  let!(:other_cost) { create(:cost, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    context 'トップ画面の表示の確認' do
      it 'カレンダーが表示される' do
        expect(page).to have_link '翌月'
      end
    end
  end

  describe '収入科目一覧のテスト' do
    before do
      visit incomes_path
    end
    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        #byebug
        expect(page).to have_content income.name
      end
      it 'valueが正しく表示される' do
        expect(page).to have_content income.value
      end
    end
  end

  describe '収入科目新規登録のテスト' do
    before do
      visit new_income_path
    end
    context '表示内容の確認' do
      it 'start_timeフォームが正しく表示される' do
        expect(page).to have_field 'income[start_time(1i)]'
        expect(page).to have_field 'income[start_time(2i)]'
        expect(page).to have_field 'income[start_time(3i)]'
      end
      it 'nameフォームが正しく表示される' do
        expect(page).to have_field 'income[name]'
      end
      it 'valueフォームが正しく表示される' do
        expect(page).to have_field 'income[value]'
      end
      it 'descriptionフォームが正しく表示される' do
        expect(page).to have_field 'income[description]'
      end
      it '登録するボタンが正しく表示される' do
        expect(page).to have_button '登録する'
      end
    end
  end

  context '記録成功のテスト' do
    before do
      visit new_income_path
      select('2022', from: 'income[start_time(1i)]')
      select('2月', from: 'income[start_time(2i)]')
      select('1', from: 'income[start_time(3i)]')
      fill_in 'income[name]', with: Faker::Lorem.name
      fill_in 'income[value]', with: Faker::Number.between(from:100000, to: 200000)
      fill_in 'income[description]', with: Faker::Lorem.word
      click_button '登録する'
    end
    it '自分の新しい記録が正しく保存される' do
      #expect { click_button '登録する' }.to change(user.incomes, :count).by(1)
      #print  page.body
      expect(user.incomes.size).to eq 2
      expect(user.incomes[0].cost.value).to eq user.incomes[0].value
    end
  end

  describe '収入科目詳細画面のテスト' do
    before do
      visit income_path(income.id)
    end

    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        expect(page).to have_content income.name
      end
      it 'valueが正しく表示される' do
        expect(page).to have_content income.value
      end
    end
  end

  describe '収入科目編集画面のテスト' do
    before do
      visit edit_income_path(income.id)
    end
    context '表示の確認' do
      it 'start_timeフォームが正しく表示される' do
        expect(page).to have_field 'income[start_time(1i)]'
        expect(page).to have_field 'income[start_time(2i)]'
        expect(page).to have_field 'income[start_time(3i)]'
      end
      it 'nameフォームが正しく表示される' do
        expect(page).to have_field 'income[name]', with: income.name
      end
      it 'valueフォームが正しく表示される' do
        expect(page).to have_field 'income[value]', with: income.value
      end
      it 'descriptionフォームが正しく表示される' do
        expect(page).to have_field 'income[description]', with: income.description
      end
      it '登録するボタンが正しく表示される' do
        expect(page).to have_button '登録する'
      end
    end
    context '編集成功のテスト' do
      before do
        @income_old_name = income.name
        @income_old_value = income.value
        fill_in 'income[name]', with: Faker::Name.name
        fill_in 'income[value]', with: Faker::Number.between(from:100000, to: 200000)
        click_button '登録する'
      end
      it 'nameが正しく更新される' do
        expect(income.reload.name).not_to eq @income_old_name
      end
      it 'valueが正しく更新される' do
        expect(income.reload.value).not_to eq @income_old_intrpduction
      end
    end
  end

  describe '固定費科目一覧のテスト' do
    before do
      visit fixedcosts_path
    end
    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        expect(page).to have_content fixedcost.name
      end
      it 'valueが正しく表示される' do
        expect(page).to have_content fixedcost.value
      end
    end
  end

  describe '固定費科目新規登録のテスト' do
    before do
      visit new_fixedcost_path
    end
    context '表示内容の確認' do
      it 'start_timeフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[start_time(1i)]'
        expect(page).to have_field 'fixedcost[start_time(2i)]'
        expect(page).to have_field 'fixedcost[start_time(3i)]'
      end
      it 'nameフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[name]'
      end
      it 'valueフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[value]'
      end
      it 'descriptionフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[description]'
      end
      it '登録するボタンが正しく表示される' do
        expect(page).to have_button '登録する'
      end
    end
  end

  context '記録成功のテスト' do
    before do
      visit new_fixedcost_path
      select('2022', from: 'fixedcost[start_time(1i)]')
      select('2月', from: 'fixedcost[start_time(2i)]')
      select('1', from: 'fixedcost[start_time(3i)]')
      fill_in 'fixedcost[name]', with: Faker::Lorem.name
      fill_in 'fixedcost[value]', with: Faker::Number.between(from:100000, to: 200000)
      fill_in 'fixedcost[description]', with: Faker::Lorem.word
      click_button '登録する'
    end
    it '自分の新しい記録が正しく保存される' do
      expect(user.fixedcosts.size).to eq 2
      expect(user.fixedcosts[0].cost.value).to eq user.fixedcosts[0].value
    end
  end

  describe '固定費科目詳細画面のテスト' do
    before do
      visit fixedcost_path(fixedcost.id)
    end

    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        expect(page).to have_content fixedcost.name
      end
      it 'valueが正しく表示される' do
        expect(page).to have_content fixedcost.value
      end
    end
  end

  describe '固定費科目編集画面のテスト' do
    before do
      visit edit_fixedcost_path(fixedcost.id)
    end
    context '表示の確認' do
      it 'start_timeフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[start_time(1i)]'
        expect(page).to have_field 'fixedcost[start_time(2i)]'
        expect(page).to have_field 'fixedcost[start_time(3i)]'
      end
      it 'nameフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[name]', with: fixedcost.name
      end
      it 'valueフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[value]', with: fixedcost.value
      end
      it 'descriptionフォームが正しく表示される' do
        expect(page).to have_field 'fixedcost[description]', with: fixedcost.description
      end
      it '登録するボタンが正しく表示される' do
        expect(page).to have_button '登録する'
      end
    end
    context '編集成功のテスト' do
      before do
        @fixedcost_old_name = fixedcost.name
        @fixedcost_old_value = fixedcost.value
        fill_in 'fixedcost[name]', with: Faker::Name.name
        fill_in 'fixedcost[value]', with: Faker::Number.between(from:100000, to: 200000)
        click_button '登録する'
      end
      it 'nameが正しく更新される' do
        expect(fixedcost.reload.name).not_to eq @fixedcost_old_name
      end
      it 'valueが正しく更新される' do
        expect(fixedcost.reload.value).not_to eq @fixedcost_old_intrpduction
      end
    end
  end

  describe '変動費科目一覧のテスト' do
    before do
      visit variablecosts_path
    end
    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        expect(page).to have_content variablecost.name
      end
      it 'valueが正しく表示される' do
        expect(page).to have_content variablecost.value
      end
    end
  end

  describe '変動費科目新規登録のテスト' do
    before do
      visit new_variablecost_path
    end
    context '表示内容の確認' do
      it 'start_timeフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[start_time(1i)]'
        expect(page).to have_field 'variablecost[start_time(2i)]'
        expect(page).to have_field 'variablecost[start_time(3i)]'
      end
      it 'nameフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[name]'
      end
      it 'valueフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[value]'
      end
      it 'descriptionフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[description]'
      end
      it '登録するボタンが正しく表示される' do
        expect(page).to have_button '登録する'
      end
    end
  end

  context '記録成功のテスト' do
    before do
      visit new_variablecost_path
      select('2022', from: 'variablecost[start_time(1i)]')
      select('2月', from: 'variablecost[start_time(2i)]')
      select('1', from: 'variablecost[start_time(3i)]')
      fill_in 'variablecost[name]', with: Faker::Lorem.name
      fill_in 'variablecost[value]', with: Faker::Number.between(from:100000, to: 200000)
      fill_in 'variablecost[description]', with: Faker::Lorem.word
      click_button '登録する'
    end
    it '自分の新しい記録が正しく保存される' do
      expect(user.variablecosts.size).to eq 2
      expect(user.variablecosts[0].cost.value).to eq user.variablecosts[0].value
    end
  end

  describe '変動費科目詳細画面のテスト' do
    before do
      visit variablecost_path(variablecost.id)
    end

    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        expect(page).to have_content variablecost.name
      end
      it 'valueが正しく表示される' do
        expect(page).to have_content variablecost.value
      end
    end
  end

  describe '変動費科目編集画面のテスト' do
    before do
      visit edit_variablecost_path(variablecost.id)
    end
    context '表示の確認' do
      it 'start_timeフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[start_time(1i)]'
        expect(page).to have_field 'variablecost[start_time(2i)]'
        expect(page).to have_field 'variablecost[start_time(3i)]'
      end
      it 'nameフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[name]', with: variablecost.name
      end
      it 'valueフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[value]', with: variablecost.value
      end
      it 'descriptionフォームが正しく表示される' do
        expect(page).to have_field 'variablecost[description]', with: variablecost.description
      end
      it '登録するボタンが正しく表示される' do
        expect(page).to have_button '登録する'
      end
    end
    context '編集成功のテスト' do
      before do
        @variablecost_old_name = variablecost.name
        @variablecost_old_value = variablecost.value
        fill_in 'variablecost[name]', with: Faker::Name.name
        fill_in 'variablecost[value]', with: Faker::Number.between(from:100000, to: 200000)
        click_button '登録する'
      end
      it 'nameが正しく更新される' do
        expect(variablecost.reload.name).not_to eq @variablecost_old_name
      end
      it 'valueが正しく更新される' do
        expect(variablecost.reload.value).not_to eq @variablecost_old_intrpduction
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'nameが正しく表示される' do
        expect(page).to have_content user.name
      end
      it 'emailが正しく表示される' do
        expect(page).to have_content user.email
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user.id)
    end

    context '表示の確認' do
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_email= user.email
        fill_in 'user[name]', with: Faker::Name.name
        fill_in 'user[email]', with: Faker::Internet.email
        click_button '更新する'
      end
      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
      end
    end
  end
end
