require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validation of create Member' do
    describe 'presence: true' do
      it 'numberがblankの場合エラーになる' do
        member = Member.new number: nil, name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: [1, 2].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:number]).to include('を入力してください')
      end

      it 'nameがblankの場合エラーになる' do
        member = Member.new number: rand(20), name: '', full_name: '田中太郎', email: 'taro@example.com', sex: [1, 2].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:name]).to include('を入力してください')
      end

      it 'full_nameがblankの場合エラーになる' do
        member = Member.new number: rand(20), name: 'Taro', full_name: '', email: 'taro@example.com', sex: [1, 2].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:full_name]).to include('を入力してください')
      end
    end
  end
end
