require 'rails_helper'

RSpec.describe 'ActivityLogValidation', type: :model do
  let(:member) { create :member }
  let(:article) { create :article }

  describe 'performer' do
    describe 'presence: true' do
      it 'performerがblankの場合エラーになる' do
        activity_log = ActivityLog.new log_type: :login, performer: nil, performed_at: Time.now, performed_title: "#{article.title}"
        activity_log.valid?
        expect(activity_log.errors[:performer]).to include('を入力してください')
      end
    end
  end

  describe 'log_type' do
    describe 'presence: true' do
      it 'log_typeがblankの場合エラーになる' do
        activity_log = ActivityLog.new log_type: nil, performer: member, performed_at: Time.now, performed_title: "#{article.title}"
        activity_log.valid?
        expect(activity_log.errors[:log_type]).to include('を入力してください')
      end
    end

    describe 'inclusion' do
      it 'LOG_TYPE_VALUES内の値であればtrueが返る' do
        activity_log = ActivityLog.new log_type: :login, performer: member, performed_at: Time.now, performed_title: "#{article.title}"
        activity_log.valid?
        expect(activity_log.valid?).to be_truthy
      end
    end
  end

  describe 'performed_at' do
    describe 'presence: true' do
      it 'performed_atがblankの場合エラーになる' do
        activity_log = ActivityLog.new log_type: :login, performer: member, performed_at: nil, performed_title: "#{article.title}"
        activity_log.valid?
        expect(activity_log.errors[:performed_at]).to include('を入力してください')
      end
    end
  end
end
