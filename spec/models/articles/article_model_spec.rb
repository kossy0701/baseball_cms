require 'rails_helper'

RSpec.describe 'ArticleModel', type: :model do
  describe 'def no_expiration' do
    it 'expired_atがnilの場合trueを返す' do
      article = Article.new title: '練習試合の結果', body: "#{'河川敷クリーナーズ が 6 - 4 で勝ちました。' * 100}", released_at: Date.today, member_only: false, expired_at: nil
      expect(article.no_expiration).to be_truthy
    end

    it 'expired_atに値がある場合falseを返す' do
      article = Article.new title: '練習試合の結果', body: "#{'河川敷クリーナーズ が 6 - 4 で勝ちました。' * 100}", released_at: Date.today, member_only: false, expired_at: Date.today.in(1.days)
      expect(article.no_expiration).to be_falsey
    end
  end

  describe 'def no_expiration=(val)' do
    it 'valがtrueか1の場合、@no_expirationはtrueが代入される' do
      article = Article.new title: '練習試合の結果', body: "#{'河川敷クリーナーズ が 6 - 4 で勝ちました。' * 100}", released_at: Date.today, member_only: false, expired_at: Date.today.in(1.days)
      expect(article.no_expiration=([true, 1].sample)).to be_truthy
    end

    it 'valがfalseの場合、@no_expirationはfalseが代入される' do
      article = Article.new title: '練習試合の結果', body: "#{'河川敷クリーナーズ が 6 - 4 で勝ちました。' * 100}", released_at: Date.today, member_only: false, expired_at: Date.today.in(1.days)
      expect(article.no_expiration=(false)).to be_falsey
    end
  end
end
