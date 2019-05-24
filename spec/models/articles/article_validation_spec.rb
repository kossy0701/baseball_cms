require 'rails_helper'

RSpec.describe 'ArticleValidation', type: :model do
  describe 'title' do
    describe 'presence: true' do
      it 'titleがblankの場合エラーになる' do
        article = Article.new title: '', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', released_at: Date.today, member_only: false
        article.valid?
        expect(article.errors[:title]).to include('を入力してください')
      end
    end
    describe 'length' do
      it 'titleのlengthが80文字以上だとエラーになる' do
        article = Article.new title: "#{'練習試合の結果' * 20}", body: '河川敷クリーナーズ が 6 - 4 で勝ちました。',released_at: Date.today, member_only: false
        article.valid?
        expect(article.errors[:title]).to include('は80文字以内で入力してください')
      end
    end
  end

  describe 'body' do
    describe 'presence: true' do
      it 'bodyがblankの場合エラーになる' do
        article = Article.new title: '練習試合の結果', body: '', released_at: Date.today, member_only: false
        article.valid?
        expect(article.errors[:body]).to include('を入力してください')
      end
    end
    describe 'length' do
      it 'bodyのlengthが2000文字以上だとエラーになる' do
        article = Article.new title: '練習試合の結果', body: "#{'河川敷クリーナーズ が 6 - 4 で勝ちました。' * 100}", released_at: Date.today, member_only: false
        article.valid?
        expect(article.errors[:body]).to include('は2000文字以内で入力してください')
      end
    end
  end

  describe 'released_at' do
    describe 'presence: true' do
      it 'released_atがblankの場合エラーになる' do
        article = Article.new title: '練習試合の結果', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', released_at: '', member_only: false
        article.valid?
        expect(article.errors[:released_at]).to include('を入力してください')
      end
    end
  end
end
