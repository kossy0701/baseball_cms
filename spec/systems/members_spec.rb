require 'rails_helper'

describe 'メンバー管理機能', type: :system, js: true do
  let(:member) { create :member, name: 'Taro', administrator: true }

  before do
    visit root_path
    fill_in 'name', with: login_user.name
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'メンバー検索機能' do
    let(:login_user) { member }

    it 'メンバーの検索結果が表示される' do
      visit members_path
      fill_in 'q', with: 'T'
      click_button '検索'
      expect(page).to have_content 'Taro'
    end
  end

  describe 'メンバー一覧表示機能' do
    let(:login_user) { member }

    before do
      visit root_path
    end

    it '会員一覧画面が表示される' do
      expect(page).to have_content "#{login_user.name}"
    end

  end

  describe '新規会員作成機能' do
    let(:login_user) { member }

    before do
      visit new_member_path
      fill_in '背番号', with: '50'
      fill_in 'ユーザー名', with: 'Hide'
      fill_in '氏名', with: '平塚 明'
      find("input[value='female']").set(true)
      select '1980', from: 'member_birthday_1i'
      select '5', from: 'member_birthday_2i'
      select '1', from: 'member_birthday_3i'
      select '東京都', from: '出身地'
      fill_in 'メールアドレス', with: 'nobuchan@example.com'
      fill_in '新しいパスワード', with: '12345678'
      fill_in '新しいパスワードの確認', with: '12345678'
      click_button '登録する'
    end

    it '作成した会員が表示される' do
      expect(page).to have_content 'Hide'
    end
  end

  describe '会員詳細表示機能' do
    let(:login_user) { member }

    before do
      visit member_path(login_user)
    end

    it '作成した会員が表示される' do
      expect(page).to have_content "#{login_user.name}"
    end
  end

  describe '会員情報編集機能' do
    let(:login_user) { member }

    before do
      visit edit_member_path(login_user)
      fill_in '背番号', with: '50'
      fill_in 'ユーザー名', with: 'Hide'
      fill_in '氏名', with: '織田信長'
      find("input[value='female']").set(true)
      select '1980', from: 'member_birthday_1i'
      select '5', from: 'member_birthday_2i'
      select '1', from: 'member_birthday_3i'
      select '東京都', from: '出身地'
      fill_in 'メールアドレス', with: 'nobuchan@example.com'
      click_button '更新する'
    end

    it '編集した会員の情報が表示される' do
      expect(page).to have_content 'Hide'
    end
  end

  describe '会員削除機能' do
    let(:login_user) { member }
    !let(:other_member) { create :member }

    it '「会員を削除しました」と表示される' do
      visit members_path
      click_on '削除'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector '.notice', text: '会員を削除しました'
    end
  end
end
