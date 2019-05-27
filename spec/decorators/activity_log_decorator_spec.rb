require 'rails_helper'

RSpec.describe ActivityLogDecorator, type: :decorator do
  describe 'ActivityLogDecoratorに定義したメソッドが正しく動作すること' do
    describe 'log_type_view' do
      describe 'log_typeが:loginの場合' do
        let(:member) { create :member }
        let(:activity_log) { create :activity_log, performer_id: member.id, performer_type: member.class.to_s, log_type: :login }
        subject { activity_log.decorate }

        it 'ログインと表示される' do
          expect(subject.log_type_view).to have_content 'ログイン'
        end
      end
      describe 'log_typeが:logoutの場合' do
        let(:member) { create :member }
        let(:activity_log) { create :activity_log, performer_id: member.id, performer_type: member.class.to_s, log_type: :logout }
        subject { activity_log.decorate }

        it 'ログアウトと表示される' do
          expect(subject.log_type_view).to have_content 'ログアウト'
        end
      end
    end

    describe 'performed_date' do
      let(:member) { create :member }
      let(:activity_log) { create :activity_log, performer_id: member.id, performer_type: member.class.to_s, log_type: :login }
      subject { activity_log.decorate }

      it '%Y/%m/%d %H:%Mの形式で表示される' do
        expect(subject.performed_date).to have_content '/'
      end
    end
  end
end
