class ArticleSearchForm
  include ActiveModel::Model

  attr_accessor :title

  def search(query)
    Article.where('title LIKE ? ', "%#{query}%")
  end
end
