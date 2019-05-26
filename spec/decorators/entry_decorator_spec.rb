require 'rails_helper'

RSpec.describe EntryDecorator, type: :decorator do
  describe 'EntryDecoratorに定義したメソッドが正しく動作すること' do
    describe 'self.status_text(status)' do
      describe 'statusがdraftの場合' do
        let(:member) { create :member }
        let(:entry) { create :entry, status: 'draft', member_id: member.id }

        it '下書きと表示される' do
          expect(EntryDecorator.status_text(entry.status)).to have_content '下書き'
        end
      end
      describe 'statusがmember_onlyの場合' do
        let(:member) { create :member }
        let(:entry) { create :entry, status: 'member_only', member_id: member.id }

        it '会員限定と表示される' do
          expect(EntryDecorator.status_text(entry.status)).to have_content '会員限定'
        end
      end
      describe 'statusがpublicの場合' do
        let(:member) { create :member }
        let(:entry) { create :entry, status: 'public', member_id: member.id }

        it '公開と表示される' do
          expect(EntryDecorator.status_text(entry.status)).to have_content '公開'
        end
      end
    end

    describe 'posted_date' do
      let(:member) { create :member }
      let(:entry) { create :entry, member_id: member.id }
      subject { entry.decorate }

      it '%Y/%m/%d %H:%Mの形式で表示される' do
        expect(subject.posted_date).to have_content '/'
      end
    end
  end
end
