require 'rails_helper'

describe 'ニュース記事管理機能', type: :system do
  describe '管理者ユーザー' do
    let(:member) { create :member, administrator: true }
    let(:article) { create :article, title: '河川敷', member_only: true }

    before do
      create_list :article, 5, title: '練習試合', member_only: true
      create_list :article, 5, title: '大会の結果', member_only: false
      visit root_path
      fill_in 'name', with: login_user.name
      fill_in 'password', with: login_user.password
      click_button 'ログイン'
    end

    describe 'ニュース記事一覧表示機能' do
      let(:login_user) { member }

      it 'ニュース記事の一覧が表示される' do
        visit articles_path
        expect(page).to have_content '練習試合'
      end
    end

    describe 'ニュース記事新規作成機能' do
      let(:login_user) { member }

      before do
        visit new_admin_article_path
        fill_in 'タイトル', with: 'Perfect Human'
        fill_in '本文', with: "#{'絶対勝つぞ、' * 10}"
        select '2019', from: 'article_released_at_1i'
        select '5', from: 'article_released_at_2i'
        select '18', from: 'article_released_at_3i'
        select '09', from: 'article_released_at_4i'
        select '30', from: 'article_released_at_5i'
        click_button '登録する'
      end

      it 'ニュース記事を作成できる' do
        visit admin_articles_path
        expect(page).to have_content 'Perfect Human'
      end
    end

    describe 'ニュース記事詳細表示機能' do
      let(:login_user) { member }

      it 'ニュース記事の詳細が表示される' do
        body = article.body
        visit article_path(article)
        expect(page).to have_content body
      end
    end

    describe 'ニュース記事検索機能' do
      let(:login_user) { member }

      it 'ニュース記事の検索結果が表示される' do
        title = article.title
        visit articles_path
        fill_in 'q', with: '河川敷'
        click_button '検索'
        expect(page).to have_content '河川敷'
      end
    end
  end
end
