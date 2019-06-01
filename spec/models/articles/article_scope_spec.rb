require 'rails_helper'

RSpec.describe 'ArticleScope', type: :model do
  let!(:article_1) { create :article, member_only: true }
  let!(:article_2) { create :article, member_only: true }
  let!(:article_3) { create :article, expired_at: Date.today, member_only: false }

  describe ':open_to_the_public' do
    it 'member_onlyがfalseの記事が検索される' do
      expect(Article.open_to_the_public).to include(article_3)
    end

    it 'member_onlyがtrueの記事は検索されない' do
      expect(Article.open_to_the_public).to_not include(article_1, article_2)
    end
  end

  describe ':visible' do
    it '(released_at <= ?, now)かつ(expired_at > ? OR expired_at IS NULL , now)の記事が検索される' do
      expect(Article.visible).to include(article_1, article_2)
    end

    it '(released_at <= ?, now)かつ(expired_at > ? OR expired_at IS NULL , now)でない記事は検索されない' do
      expect(Article.visible).to_not include(article_3)
    end
  end
end
