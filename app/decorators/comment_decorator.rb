class CommentDecorator < Draper::Decorator
  delegate_all

  def comment_date
    created_at.strftime.strftime('%Y/%m/%d %H:%M')
  end

end
