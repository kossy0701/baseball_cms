class ArticleSearchForm
  include ActiveModel::Model

  attr_accessor :title

  def search(query)
    rel = Article.where('title LIKE ? ', "%#{query}%")
  end

end
