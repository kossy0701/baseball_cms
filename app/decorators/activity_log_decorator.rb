class ActivityLogDecorator < Draper::Decorator
  delegate_all

  def log_type_view
    { login: 'ログイン', logout: 'ログアウト' }[log_type.to_sym]
  end
end
