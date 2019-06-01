class ActivityLogDecorator < Draper::Decorator

  delegate_all

  def log_type_view
    { login: 'ログイン', logout: 'ログアウト', member_csv: 'メンバー CSV DL', log_csv: 'ログ CSV DL' }[log_type.to_sym]
  end

  def performed_date
    performed_at.strftime('%Y/%m/%d %H:%M')
  end

end
