require 'rails_helper'

RSpec.describe Vote, type: :model do
  let!(:member_1) { create :member }
  let!(:member_2) { create :member }
  let!(:entry) { create :entry, author: member_1 }

  describe 'validate' do
    it '自分の書いた記事には投票できない' do
      vote = Vote.new(member: member_1, entry: entry)
      vote.valid?

      expect(vote.errors[:base]).to include('は不正な値です')
    end

    it '他者の書いた記事に投票できる' do
      vote = Vote.new(member: member_2, entry: entry)
      vote.valid?

      expect(vote.valid?).to be_truthy
    end
  end
end
