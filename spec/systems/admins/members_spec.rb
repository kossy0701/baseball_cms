require 'rails_helper'

describe 'メンバー管理機能', type: :system do
  describe 'ログイン済(administrator: false)' do
    let(:member) { create :member, name: 'Taro', administrator: false }

    before do
      visit root_path
      fill_in 'name', with: login_member.name
      fill_in 'password', with: login_member.password
      click_button 'ログイン'
    end

    describe 'メンバー検索機能' do
      let(:login_member) { member }

      it 'メンバーの検索結果が表示される' do
        visit members_path
        fill_in 'q', with: 'T'
        click_button '検索'
        expect(page).to have_content 'Taro'
      end
    end

    describe 'メンバー一覧表示機能' do
      let(:login_member) { member }

      before do
        visit root_path
      end

      it '会員一覧画面が表示される' do
        expect(page).to have_content "#{login_member.name}"
      end
    end

    describe '会員詳細表示機能' do
      let(:login_member) { member }

      it '会員の詳細が表示される' do
        visit member_path(login_member)
        expect(page).to have_content "#{login_member.name}"
      end
    end
  end

  describe '未ログイン' do
    describe 'メンバー検索機能' do
      it 'ログインが必要ですと表示される' do
        visit members_path
        expect(page).to have_content 'ログインが必要です'
      end
    end

    describe 'メンバー一覧表示機能' do
      it 'ログインが必要ですと表示される' do
        visit members_path
        expect(page).to have_content 'ログインが必要です'
      end
    end

    describe '会員詳細表示機能' do
      let(:member) { create :member }

      it 'ログインが必要ですと表示される' do
        visit member_path(member)
        expect(page).to have_content 'ログインが必要です'
      end
    end
  end
end
