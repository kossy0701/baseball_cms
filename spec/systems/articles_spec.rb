require 'rails_helper'

describe 'ニュース記事管理機能', type: :system do
  let(:member) { create :member }

  before do
    visit root_path
    fill_in 'name', with: login_user.name
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'ニュース記事一覧表示機能' do
    let(:article) { create :article }
    let(:login_user) { member }

    it '記事の一覧が表示される' do
      title = article.title
      visit articles_path
      expect(page).to have_content title
    end
  end

  describe 'ニュース記事新規作成機能' do
    let(:login_user) { member }

    before do
      visit new_article_path
      fill_in 'タイトル', with: 'Perfect Human'
      fill_in '本文', with: "#{'絶対勝つぞ、' * 10}"
      select '2019', from: 'article_released_at_1i'
      select '5', from: 'article_released_at_2i'
      select '18', from: 'article_released_at_3i'
      select '09', from: 'article_released_at_4i'
      select '30', from: 'article_released_at_5i'
      click_button '登録する'
    end

    it '作成したレビューが表示される' do
      expect(page).to have_content 'Perfect Human'
    end
  end
end
