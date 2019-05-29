require 'rails_helper'

describe 'メンバー管理機能', type: :system, js: true do
  describe 'ログイン済(administrator: false)' do
    let(:member) { create :member, name: 'Taro', administrator: false }

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

    describe '会員詳細表示機能' do
      let(:login_user) { member }

      it '会員の詳細が表示される' do
        visit member_path(login_user)
        expect(page).to have_content "#{login_user.name}"
      end
    end
  end
end
