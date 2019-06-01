require 'rails_helper'

describe 'ブログ管理機能', type: :system, js: true do
  describe 'ログイン済(administrator: false)' do
    let(:member_1) { create :member, administrator: false }
    let(:member_2) { create :member, administrator: false }
    let(:entry_1) { create :entry, member_id: member_1.id, status: 'public' }
    let(:entry_2) { create :entry, member_id: member_2.id, status: 'member_only' }

    before do
      visit root_path
      fill_in 'name', with: login_member.name
      fill_in 'password', with: login_member.password
      click_button 'ログイン'
    end

    describe 'ブログ一覧表示機能' do
      let(:login_member) { member_1 }

      it 'ブログの一覧が表示される' do
        title = entry_1.title
        visit entries_path
        expect(page).to have_content title
      end
    end

    describe 'ブログ新規作成機能' do
      let(:login_member) { member_1 }

      before do
        visit new_entry_path
        fill_in 'タイトル', with: 'Perfect Human'
        fill_in '本文', with: "#{'絶対勝つぞ、' * 10}"
        select '2019', from: 'entry_posted_at_1i'
        select '5', from: 'entry_posted_at_2i'
        select '18', from: 'entry_posted_at_3i'
        select '09', from: 'entry_posted_at_4i'
        select '30', from: 'entry_posted_at_5i'
        select '下書き'
        click_button '登録する'
      end

      it '作成したブログが表示される' do
        expect(page).to have_content 'Perfect Human'
      end
    end

    describe 'ブログ詳細表示機能' do
      let(:login_member) { member_1 }

      it 'ブログの詳細が表示される' do
        title = entry_1.title
        visit entry_path(entry_1)
        expect(page).to have_content title
      end
    end

    describe 'ブログ編集機能' do
      let(:login_member) { member_1 }

      before do
        visit edit_entry_path(entry_1)
        fill_in 'タイトル', with: 'Perfect Human'
        fill_in '本文', with: "#{'絶対勝つぞ、' * 10}"
        select '2019', from: 'entry_posted_at_1i'
        select '5', from: 'entry_posted_at_2i'
        select '18', from: 'entry_posted_at_3i'
        select '09', from: 'entry_posted_at_4i'
        select '30', from: 'entry_posted_at_5i'
        select '下書き'
        click_button '更新する'
      end

      it '編集したブログが表示される' do
        expect(page).to have_content 'Perfect Human'
      end
    end

    describe 'ブログ削除機能' do
      let(:login_member) { member_1 }

      it '自分が執筆したブログは削除できる' do
        entry_1.save
        visit entries_path
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content 'Perfect Human'
      end
    end

    describe 'ブログ削除機能' do
      let(:login_member) { member_1 }

      it '他者が執筆したブログは削除できない' do
        entry_2.save
        expect(page).to_not have_content '削除'
      end
    end
  end

  describe '未ログイン' do
    let(:member_1) { create :member, administrator: false }
    let(:member_2) { create :member, administrator: false }
    let(:entry_1) { create :entry, member_id: member_1.id }
    let(:entry_2) { create :entry, member_id: member_2.id }

    describe 'ブログ一覧表示機能' do
      it 'ブログの一覧が表示される' do
        member_1.save
        entry_1.save
        visit entries_path
        expect(page).to have_content entry_1.title
      end
    end

    describe 'ブログ新規作成機能' do
      it 'ログインが必要ですと表示される' do
        visit new_entry_path
        expect(page).to have_content 'ログインが必要です'
      end
    end

    describe 'ブログ詳細表示機能' do
      it 'ブログの詳細が表示される' do
        member_1.save
        entry_1.save
        visit entry_path(entry_1)
        expect(page).to have_content entry_1.title
      end
    end

    describe 'ブログ編集機能' do
      it 'ログインが必要ですと表示される' do
        entry_1.save
        visit edit_entry_path(entry_1)
        expect(page).to have_content 'ログインが必要です'
      end
    end

    describe 'ブログ削除機能' do
      it 'ログインが必要ですと表示される' do
        entry_1.save
        visit entries_path
        expect(page).to_not have_content '削除'
      end
    end
  end
end
