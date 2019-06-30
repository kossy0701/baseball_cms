require 'rails_helper'

RSpec.describe 'EntryValidation', type: :model do
  let!(:member) { create :member }

  describe 'title' do
    describe 'presence: true' do
      it 'titleがblankの場合エラーになる' do
        entry = Entry.new title: '', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', posted_at: Date.today, status: 'draft', member_id: member.id
        entry.valid?
        expect(entry.errors[:title]).to include('を入力してください')
      end
    end
    describe 'length' do
      it 'lengthが200文字以上の場合エラーになる' do
        entry = Entry.new title: "#{'河川敷クリーナーズ が 6 - 4 で勝ちました。' * 100}", body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', posted_at: Date.today, status: 'draft', member_id: member.id
        entry.valid?
        expect(entry.errors[:title]).to include('は200文字以内で入力してください')
      end
    end
  end

  describe 'body' do
    describe 'presence: true' do
      it 'bodyがblankの場合エラーになる' do
        entry = Entry.new title: '河川敷クリーナーズ が 6 - 4 で勝ちました。', body: nil, posted_at: Date.today, status: 'draft', member_id: member.id
        entry.valid?
        expect(entry.errors[:body]).to include('を入力してください')
      end
    end
  end

  describe 'posted_at' do
    describe 'presence: true' do
      it 'posted_atがblankの場合エラーになる' do
        entry = Entry.new title: '河川敷クリーナーズ が 6 - 4 で勝ちました。', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', posted_at: nil, status: 'draft', member_id: member.id
        entry.valid?
        expect(entry.errors[:posted_at]).to include('を入力してください')
      end
    end
  end

  describe 'status' do
    describe 'inclusion: { in: STATUS_VALUES }' do
      it 'STATUS_VALUESの値であればtrueが返る' do
        entry = Entry.new title: '河川敷クリーナーズ が 6 - 4 で勝ちました。', body: '河川敷クリーナーズ が 6 - 4 で勝ちました。', posted_at: Date.today, status: 'draft', member_id: member.id
        expect(entry.valid?).to be_truthy
      end
    end
  end
end
