class MemberDecorator < Draper::Decorator
  delegate_all

  def show_sex
    sex == 'male' ? '男' : '女'
  end

  def administrate_display
    administrator == true ? '○' : '－'
  end

  def show_birthday
    birthday&.strftime('%Y年%m月%d日')
  end

  def age
    date = Date.today
    ((date.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10_000).to_s + '歳'
  end
end
