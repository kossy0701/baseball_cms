require 'rails_helper'

describe 'ブログ管理機能', type: :system do
  let(:member) { create :member, administrator: true }
  let(:entry_1) { create :entry, member_id: member.id }
  let(:entry_2) { create :entry, member_id: member.id }

  before do
    visit root_path
    fill_in 'name', with: login_user.name
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'ブログ一覧表示機能' do
    let(:login_user) { member }

    it '記事の一覧が表示される' do
      title = entry_1.title
      visit entries_path
      expect(page).to have_content title
    end
  end

  describe 'ブログ新規作成機能' do
    let(:login_user) { member }

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

    it '作成したレビューが表示される' do
      expect(page).to have_content 'Perfect Human'
    end
  end
end
