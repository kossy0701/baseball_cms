require 'rails_helper'

RSpec.describe MemberDecorator, type: :decorator do
  describe 'MemberDecoratorに定義したメソッドが正しく動作すること' do
    describe 'show_sex' do
      describe 'sexがmaleの場合' do
        let(:member) { create :member, sex: :male }
        subject { member.decorate }

        it '男と表示される' do
          sex = subject.show_sex
          expect(sex).to eq '男'
        end
      end

      describe 'sexがfemaleの場合' do
        let(:member) { create :member, sex: :female }
        subject { member.decorate }

        it '女と表示される' do
          sex = subject.show_sex
          expect(sex).to eq '女'
        end
      end
    end

    describe 'administrate_display' do
      describe 'administratorがtrueの場合' do
        let(:member) { create :member, administrator: true }
        subject { member.decorate }

        it '○と表示される' do
          expect(subject.administrate_display).to eq '○'
        end
      end

      describe 'administratorがfalseの場合' do
        let(:member) { create :member, administrator: false }
        subject { member.decorate }

        it '－と表示される' do
          expect(subject.administrate_display).to eq '－'
        end
      end
    end

    describe 'show_birthday' do
      let(:member) { create :member }
      subject { member.decorate }

      it '%Y年%m月%d日と表示される' do
        expect(subject.show_birthday).to have_content '年'
      end
    end

    describe 'age' do
      let(:member) { create :member }
      subject { member.decorate }

      it '年齢が表示される' do
        expect(subject.age).to have_content '歳'
      end
    end
  end
end
