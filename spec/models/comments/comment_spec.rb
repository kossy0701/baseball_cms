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
end
