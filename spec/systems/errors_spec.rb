require 'rails_helper'

describe 'エラーページ表示機能', type: :system do
  describe '403 LoginRequired' do
    it 'ログインが必要ですと表示される' do
      visit members_path
      expect(page).to have_content 'ログインが必要です'
    end
    it 'このページにはアクセスできませんと表示される' do
      visit admin_root_path
      expect(page).to have_content 'このページにはアクセスできません'
    end
  end
end
