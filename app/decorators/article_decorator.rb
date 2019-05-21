class ArticleDecorator < Draper::Decorator
  delegate_all

  def released_date
    released_at.strftime('%Y/%m/%d %H:%M')
  end

  def expired_date
    expired_at.try(:strftime, '%Y/%m/%d %H:%M')
  end

  def member_only?
    member_only == true ? '○' : '－'
  end

end
