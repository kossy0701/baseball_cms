require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:member) { create :member }
  let(:article) { create :article }
  describe 'body' do
    describe 'presence: true' do
      it 'bodyがblankの場合エラーになる' do
        comment = Comment.new commenter: member, article: article, body: nil
        comment.valid?
        expect(comment.errors[:body]).to include('を入力してください')
      end
    end
  end

  describe 'method' do
    describe 'def commented_date' do
      it '%Y/%m/%d %H:%Mの形式で表示される' do
        comment = ArticleComment.new commenter: member, article: article, body: 'コメント'
        comment.save!
        date = Time.now.localtime.strftime('%Y/%m/%d %H:%M')
        expect(comment.commented_date).to eq date
      end
    end
  end
end
