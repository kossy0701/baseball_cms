require 'rails_helper'

RSpec.describe ArticleDecorator, type: :decorator do
  describe 'ArticleDecoratorに定義したメソッドが正しく動作すること' do
    describe 'released_date' do
      let(:article) { create :article }
      subject { article.decorate }

      it '%Y/%m/%d %H:%Mの形式で表示される' do
        expect(subject.released_date).to have_content '/'
      end
    end

    describe 'expired_date' do
      let(:article) { create :article }
      subject { article.decorate }

      it '%Y/%m/%d %H:%Mの形式で表示される' do
        expect(subject.released_date).to have_content '/'
      end
    end

    describe 'member_only_display' do
      describe 'member_onlyがtrueの場合' do
        let(:article) { create :article, member_only: true }
        subject { article.decorate }

        it '○と表示される' do
          expect(subject.member_only_display).to eq '○'
        end
      end

      describe 'member_onlyがfalseの場合' do
        let(:article) { create :article, member_only: false }
        subject { article.decorate }

        it '－と表示される' do
          expect(subject.member_only_display).to eq '－'
        end
      end
    end
  end
end
