require 'rails_helper'

RSpec.describe ActivityLogDecorator, type: :decorator do
  describe 'ActivityLogDecoratorに定義したメソッドが正しく動作すること' do
    describe 'log_type_view' do
      describe 'log_typeが:loginの場合' do
        let(:member) { create :member }
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :login }
        subject { activity_log.decorate }

        it 'ログインと表示される' do
          expect(subject.log_type_view).to have_content 'ログイン'
        end
      end
      describe 'log_typeが:logoutの場合' do
        let(:member) { create :member }
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :logout }
        subject { activity_log.decorate }

        it 'ログアウトと表示される' do
          expect(subject.log_type_view).to have_content 'ログアウト'
        end
      end
      describe 'log_typeが:member_csvの場合' do
        let(:member) { create :member }
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :member_csv }
        subject { activity_log.decorate }

        it 'メンバー CSV DLと表示される' do
          expect(subject.log_type_view).to have_content 'メンバー CSV DL'
        end
      end
      describe 'log_typeが:log_csvの場合' do
        let(:member) { create :member }
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :log_csv }
        subject { activity_log.decorate }

        it 'ログ CSV DLと表示される' do
          expect(subject.log_type_view).to have_content 'ログ CSV DL'
        end
      end

      describe 'log_typeが:create_entry_logの場合' do
        let(:member) { create :member }
        let(:entry) { create :entry, title: '野球観戦', author: member}
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :create_entry, performed_title: entry.title }
        subject { activity_log.decorate }

        it 'ブログ: 「野球観戦」 の作成と表示される' do
          expect(subject.log_type_view).to have_content 'ブログ: 「野球観戦」 の作成'
        end
      end

      describe 'log_typeが:remove_entry_logの場合' do
        let(:member) { create :member }
        let(:entry) { create :entry, title: '野球観戦', author: member}
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :remove_entry, performed_title: entry.title }
        subject { activity_log.decorate }

        it 'ブログ: 「野球観戦」 の削除と表示される' do
          expect(subject.log_type_view).to have_content 'ブログ: 「野球観戦」 の削除'
        end
      end

      describe 'log_typeが:create_article_logの場合' do
        let(:member) { create :member }
        let(:article) { create :article, title: '河川敷クリーナーズ勝利！'}
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :create_article, performed_title: article.title }
        subject { activity_log.decorate }

        it 'ニュース: 「河川敷クリーナーズ勝利！」 の作成と表示される' do
          expect(subject.log_type_view).to have_content 'ニュース: 「河川敷クリーナーズ勝利！」 の作成'
        end
      end

      describe 'log_typeが:remove_article_logの場合' do
        let(:member) { create :member }
        let(:article) { create :article, title: '河川敷クリーナーズ勝利！'}
        let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :remove_article, performed_title: article.title }
        subject { activity_log.decorate }

        it 'ニュース: 「河川敷クリーナーズ勝利！」 の削除と表示される' do
          expect(subject.log_type_view).to have_content 'ニュース: 「河川敷クリーナーズ勝利！」 の削除'
        end
      end
    end

    describe 'performed_date' do
      let(:member) { create :member }
      let(:activity_log) { create :activity_log, performer: member, performer_type: member.class.to_s, log_type: :login }
      subject { activity_log.decorate }

      it '%Y/%m/%d %H:%Mの形式で表示される' do
        expect(subject.performed_date).to have_content '/'
      end
    end
  end
end
