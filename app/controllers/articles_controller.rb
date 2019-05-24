class ArticlesController < ApplicationController

  before_action :login_required, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order(released_at: :desc).page(params[:page]).per(15)
    @articles.open_to_the_public unless current_member

    unless current_member&.administrator?
      @articles = @articles.visible
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_permit_params
    if @article.save
      redirect_to articles_path, notice: 'ニュース記事を登録しました。'
    else
      render :new
    end
  end

  def show
    articles = Article.all

    articles = articles.open_to_the_public unless current_member

    unless current_member&.administrator?
      articles = articles.visible
    end
  end

  def edit
  end

  def update
    if @article.update article_permit_params
      redirect_to articles_path, notice: 'ニュース記事を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'ニュース記事を削除しました。'
  end

  def search
    @article_search_form = ArticleSearchForm.new article_search_params
    @articles = @article_search_form.search params[:q]
    @articles = @articles.order(released_at: :desc).page(params[:page]).per(15)
    render :index
  end

  private

  def set_article
    @article = Article.find(params[:id]).decorate
  end

  def article_permit_params
    params.require(:article).permit(:title, :body, :released_at, :member_only)
  end

  def article_search_params
    params.permit(:title)
  end

end
