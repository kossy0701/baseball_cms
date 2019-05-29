class ArticlesController < ApplicationController

  def index
    @articles = Article.visible.order(released_at: :desc)
    @articles = @articles.open_to_the_public unless current_member
    @articles = @articles.page(params[:page]).per(5)
  end

  def show
    articles = Article.visible
    articles = articles.open_to_the_public unless current_member
    @article = articles.find(params[:id])
  end

  def search
    @article_search_form = ArticleSearchForm.new article_search_params
    @articles = @article_search_form.search params[:q]
    @articles = @articles.order(released_at: :desc).page(params[:page]).per(15)
    render :index
  end

  private

  def article_search_params
    params.permit(:title)
  end

end
