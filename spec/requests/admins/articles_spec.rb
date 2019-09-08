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

    describe 'show' do
      it '200 OK' do
        article = create :article
        get article_path(article)

        expect(response.status).to eq 200
      end
    end

    describe 'edit' do
      it '200 OK' do
        article = create :article
        get edit_admin_article_path(article)

        expect(response.status).to eq 200
      end
    end

    describe 'update' do
      it '302 Found' do
        article = create :article
        patch "/admin/articles/#{article.id}", params: { article: { title: 'test', body: 'succeess!', released_at: Date.today, no_expiration: false, member_only: false } }

        expect(response.status).to eq 302
      end
    end

    describe 'destroy' do
      it '302 Found' do
        article = create :article
        delete "/admin/articles/#{article.id}"

        expect(response.status).to eq 302
      end
    end

    describe 'search' do
      it '200 OK' do
        article = create :article, title: 'テスト'
        get search_admin_articles_path, params: { title: 'テスト' }

        expect(response.status).to eq 200
        expect(response.body).to include 'テスト'
      end
    end
  end

  describe '一般ユーザー' do
    let(:member) { create :member, administrator: false }

    before do
      post session_url, params: { name: member.name, password: member.password }
    end

    describe 'index' do
      it '200 OK' do
        get admin_articles_path

        expect(response.status).to eq 403
      end
    end

    describe 'new' do
      it '200 OK' do
        get new_admin_article_path

        expect(response.status).to eq 403
      end
    end

    describe 'create' do
      it '302 Found' do
        post '/admin/articles', params: { article: { title: 'test', body: 'succeess!', released_at: Date.today, no_expiration: false, member_only: false } }

        expect(response.status).to eq 403
      end
    end

    describe 'show' do
      it '200 OK' do
        article = create :article
        get admin_article_path(article)

        expect(response.status).to eq 403
      end
    end

    describe 'edit' do
      it '200 OK' do
        article = create :article
        get edit_admin_article_path(article)

        expect(response.status).to eq 403
      end
    end

    describe 'update' do
      it '302 Found' do
        article = create :article
        patch "/admin/articles/#{article.id}", params: { article: { title: 'test', body: 'succeess!', released_at: Date.today, no_expiration: false, member_only: false } }

        expect(response.status).to eq 403
      end
    end

    describe 'destroy' do
      it '302 Found' do
        article = create :article
        delete "/admin/articles/#{article.id}"

        expect(response.status).to eq 403
      end
    end

    describe 'search' do
      it '200 OK' do
        article = create :article, title: 'テスト'
        get search_admin_articles_path, params: { title: 'テスト' }

        expect(response.status).to eq 403
      end
    end
  end
end
