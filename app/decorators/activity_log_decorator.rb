class ActivityLogDecorator < Draper::Decorator

  delegate_all

  def log_type_view
    { login: 'ログイン', logout: 'ログアウト',
      member_csv: 'メンバー CSV DL', log_csv: 'ログ CSV DL',
      create_entry: "ブログ: 「#{performed_title}」 の作成", remove_entry: "ブログ: 「#{performed_title}」 の削除",
      create_article: "ニュース:「 #{performed_title}」 の作成", remove_article: "ニュース: 「#{performed_title}」 の削除"
    }[log_type.to_sym]
  end

  def performed_date
    performed_at.strftime('%Y/%m/%d %H:%M')
  end

end
