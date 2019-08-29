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

    describe 'new' do
      it '200 OK' do
        get new_admin_article_path

        expect(response.status).to eq 200
      end
    end

    describe 'create' do
      it '302 Found' do
        post '/admin/articles', params: { article: { title: 'test', body: 'succeess!', released_at: Date.today, no_expiration: false, member_only: false } }

        expect(response.status).to eq 302
      end
    end
  end
end
