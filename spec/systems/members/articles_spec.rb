require 'rails_helper'

describe 'ニュース記事管理機能', type: :system do
  let(:member) { create :member }

  let(:article_1) { create :article, title: '練習試合' }
  let(:article_2) { create :article, title: '河川敷クリーナーズ' }

  before do
    visit root_path
    fill_in 'name', with: login_user.name
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'ニュース記事検索機能' do
    let(:login_user) { member }

    it 'ニュース記事の検索結果が表示される' do
      article_1.save
      article_2.save
      visit articles_path
      fill_in 'q', with: '練習'
      click_button '検索'
      expect(page).to have_content '練習試合'
    end
  end

  describe 'ニュース記事一覧表示機能' do
    let(:article) { create :article }
    let(:login_user) { member }

    it 'ニュース記事の一覧が表示される' do
      title = article.title
      visit articles_path
      expect(page).to have_content title
    end
  end
end
