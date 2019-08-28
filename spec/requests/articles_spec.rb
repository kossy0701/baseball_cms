require 'rails_helper'

describe 'Article API', type: :request do
  describe '管理者ユーザー' do
    let(:member) { create :member, administrator: true }

    before do
      post session_url, params: { name: member.name, password: member.password }
    end

    describe 'index' do
      it '200 OK' do
        get admin_articles_path

        expect(response.status).to eq 200
      end
    end
  end
end
