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

  describe 'before_validation' do
    describe 'self.expired_at = nil if @no_expiration' do
      it 'レコード保存時に@no_expirationがtrueならばexpired_atがnilになる' do
        next_day = Date.today.in(1.days)
        article = Article.new title: '練習試合の結果', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', released_at: Date.today, member_only: false, no_expiration: true, expired_at: next_day
        expect(article.expired_at).to eq next_day
        article.valid?
        expect(article.expired_at).to eq nil
      end

      it 'レコード保存時に@no_expirationがfalseならばexpired_atに値が入る' do
        next_day = Date.today.in(1.days)
        article = Article.new title: '練習試合の結果', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', released_at: Date.today, member_only: false, no_expiration: false, expired_at: next_day
        expect(article.expired_at).to eq next_day
        article.valid?
        expect(article.expired_at).to eq next_day
      end
    end
  end

  describe 'validate do' do
    describe 'if expired_at && expired_at < released_at' do
      it 'if expired_at && expired_at < released_atがtrueの場合errorを投げる' do
        yesterday = Date.today.ago(1.days)
        article = Article.new title: '練習試合の結果', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', released_at: Date.today, member_only: false, no_expiration: false, expired_at: yesterday
        article.valid?
        expect(article.errors.full_messages.join).to eq '掲載終了日時は掲載開始日より新しい日時にしてください'
      end

      it 'if expired_at && expired_at < released_atがfalseの場合エラーメッセージは空文字' do
        yesterday = Date.today.ago(1.days)
        article = Article.new title: '練習試合の結果', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', released_at: yesterday, member_only: false, no_expiration: false, expired_at: Date.today
        article.valid?
        expect(article.errors.full_messages.join).to eq ''
      end
    end
  end
end
