class Admin::ArticlesController < Admin::Base
  before_action :admin_login_required
  before_action :set_article, only: %i[show edit update destroy]
  after_action :create_article_log, only: :create
  after_action :remove_article_log, only: :destroy

  def index
    @articles = Article.order(released_at: :desc).page(params[:page]).per(15)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_permit_params
    if @article.save
      redirect_to admin_articles_path, notice: 'ニュース記事を登録しました'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @article.update article_permit_params
      redirect_to admin_articles_path, notice: 'ニュース記事を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path, notice: 'ニュース記事を削除しました'
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
    params.require(:article).permit(:title, :body, :released_at, :no_expiration, :expired_at, :member_only)
  end

  def article_search_params
    params.permit(:title)
  end

  def create_article_log
    ActivityLog.create! log_type: :create_article, performer: current_member, performed_at: Time.now, performed_title: @article.title
  end

  def remove_article_log
    ActivityLog.create! log_type: :remove_article, performer: current_member, performed_at: Time.now, performed_title: @article.title
  end
end
