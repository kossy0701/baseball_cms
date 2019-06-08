require 'rails_helper'

describe 'アクティビティログ管理機能', type: :system do
  describe '管理者ユーザー' do
    let(:member) { create :member, administrator: true }

    before do
      visit root_path
      fill_in 'name', with: login_user.name
      fill_in 'password', with: login_user.password
      click_button 'ログイン'
    end

    describe 'アクティビティ一覧表示機能' do
      let(:login_user) { member }

      it 'アクティビティログの一覧が表示される' do
        visit admin_activity_logs_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
end
