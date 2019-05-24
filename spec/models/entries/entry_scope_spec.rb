require 'rails_helper'

RSpec.describe 'EntryScope', type: :model do
  let!(:member_1) { create :member }
  let!(:member_2) { create :member }
  let!(:entry_1) { create :entry, member_id: member_1.id, status: 'draft' }
  let!(:entry_2) { create :entry, member_id: member_1.id, status: 'member_only' }
  let!(:entry_3) { create :entry, member_id: member_1.id, status: 'public' }
  let!(:entry_4) { create :entry, member_id: member_2.id, status: 'draft' }
  let!(:entry_5) { create :entry, member_id: member_2.id, status: 'member_only' }
  let!(:entry_6) { create :entry, member_id: member_2.id, status: 'public' }

  describe ':common' do
    it 'statusがpublicのブログが検索される' do
      expect(Entry.common).to include(entry_3, entry_6)
    end
    it 'statusがpublic以外のブログは検索されない' do
      expect(Entry.common).to_not include(entry_1, entry_2, entry_4, entry_5)
    end
  end

  describe ':published' do
    it 'statusがdraft以外のブログが検索される' do
      expect(Entry.published).to include(entry_2, entry_3, entry_5, entry_6)
    end
    it 'statusがdraft以外のブログは検索されない' do
      expect(Entry.published).to_not include(entry_1, entry_4)
    end
  end

  describe ':full' do
    it 'where(status <> ? OR member_id = ?, draft, member.id)のブログが検索される' do
      expect(Entry.full(member_1)).to include(entry_1, entry_2, entry_3, entry_5, entry_6)
    end
    it 'where(status <> ? OR member_id = ?, draft, member.id)のブログが検索されない' do
      expect(Entry.full(member_1)).to_not include(entry_4)
    end
  end

  describe ':readable_for' do
    it ':fullのブログが検索される' do
      expect(Entry.readable_for(member_1)).to include(entry_1, entry_2, entry_3, entry_5, entry_6)
    end

    it ':common' do
      expect(Entry.readable_for(nil)).to include(entry_3, entry_6)
    end
  end
end
