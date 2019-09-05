class CommentsController < ApplicationController
  before_action :login_required

  def create
    if params[:article_id].present?
      @comment = ArticleComment.new(comment_params)
      if @comment.save
        @article = @comment.article
        respond_to :js
      else
        flash.now[:alert] = 'コメントの投稿に失敗しました'
      end
    else
      @comment = EntryComment.new(comment_params)
      if @comment.save
        @entry = @comment.entry
        respond_to :js
      else
        flash.now[:alert] = 'コメントの投稿に失敗しました'
      end
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:commenter_id, :commenter_type, :article_id, :entry_id, :body)
  end
end
