require 'rails_helper'

RSpec.describe 'MemberValidation', type: :model do
  describe 'number' do
    describe 'presence: true' do
      it 'numberがblankの場合エラーになる' do
      member = Member.new number: nil, name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
      member.valid?
      expect(member.errors[:number]).to include('を入力してください')
      end
    end
    describe 'uniqueness: true' do
      it 'numberが重複している場合エラーになる' do
        create :member, number: 1
        member = Member.new number: 1, name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: nil, administrator: [true, false].sample, password: nil, password_digest: '12345678'
        member.valid?
        expect(member.errors[:number]).to include('は既に存在しています')
      end
    end
    describe 'numericality' do
      it '数値でない場合エラーになる' do
        member = Member.new number: 'あ', name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: nil, administrator: [true, false].sample, password: nil, password_digest: '12345678'
        member.valid?
        expect(member.errors[:number]).to include('は数値で入力してください')
      end
      it '0-100以外の数値の場合エラーになる' do
        member = Member.new number: 200, name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: nil, administrator: [true, false].sample, password: nil, password_digest: '12345678'
        member.valid?
        expect(member.errors[:number]).to include('は100より小さい値にしてください')
      end
    end
  end

  describe 'name' do
    describe 'presence: true' do
      it 'nameがblankの場合エラーになる' do
        member = Member.new number: rand(50), name: '', full_name: '田中太郎', email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:name]).to include('を入力してください')
      end
    end
    describe 'format' do
      it '/\A[A-Za-z][A-Za-z0-9]*\z/でないnameはエラーになる' do
        member = Member.new number: rand(50), name: '健太', full_name: '田中太郎', email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:name]).to include('は不正な値です')
      end
    end
    describe 'length' do
      it '2文字以上20文字以下ではない場合エラーになる' do
        member = Member.new number: rand(50), name: 'a', full_name: '田中太郎', email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:name]).to include('は2文字以上で入力してください')
      end
      it '2文字以上20文字以下ではない場合エラーになる' do
        member = Member.new number: rand(50), name: "#{'Michel' * 10}", full_name: '田中太郎', email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:name]).to include('は20文字以内で入力してください')
      end
    end
  end

  describe 'full_name' do
    describe  'presence: true' do
      it 'full_nameがblankの場合エラーになる' do
        member = Member.new number: rand(50), name: 'Taro', full_name: '', email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:full_name]).to include('を入力してください')
      end
    end
    describe 'length' do
      it '20文字以上の場合エラーになる' do
        member = Member.new number: rand(50), name: 'K', full_name: "#{'田中太郎' * 10}", email: 'taro@example.com', sex: [:male, :female].sample, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:name]).to include('は2文字以上で入力してください')
      end
    end
  end

  describe 'sex' do
    describe 'presence: true' do
      it 'sexがblankの場合エラーになる' do
        member = Member.new number: rand(50), name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: nil, administrator: [true, false].sample, password: '12345678', password_digest: '12345678'
        member.valid?
        expect(member.errors[:sex]).to include('を入力してください')
      end
    end
  end

  describe  'password' do
    describe 'presence: true' do
      it 'passeordがblankの場合エラーになる' do
        member = Member.new number: rand(50), name: 'Taro', full_name: '田中太郎', email: 'taro@example.com', sex: nil, administrator: [true, false].sample, password: nil, password_digest: nil
        member.valid?
        expect(member.errors[:password]).to include('を入力してください')
      end
    end
  end
end
