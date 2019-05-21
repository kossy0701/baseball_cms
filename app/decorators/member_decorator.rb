class MemberDecorator < Draper::Decorator
  delegate_all

  def show_sex
    sex == 'male' ? '男' : '女'
  end

  def administrator?
    administrator == true  ? '○' : '－'
  end

  def show_birthday
    birthday&.strftime('%Y年%m月%d日')
  end

end
