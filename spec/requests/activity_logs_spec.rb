require 'csv'

require 'rails_helper'

describe 'ActivityLog API', type: :request do
  describe '管理者ユーザー' do
    let(:member) { create :member, administrator: true }

    before do
      post session_url, params: { name: member.name, password: member.password }
    end

    describe 'index' do
      it '200 OK' do
        get admin_activity_logs_path

        expect(response.status).to eq 200
        expect(response.body).to include 'ログインしました'
      end
    end

    describe 'download' do
      it '200 OK' do
        get download_admin_activity_logs_path(format: :csv)

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'text/csv'
        expect(response.body).to include 'ログイン'
      end
    end
  end
end
