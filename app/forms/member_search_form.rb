class MemberSearchForm
  include ActiveModel::Model

  attr_accessor :name, :full_name

  def search(query)
    rel = Member.where('name LIKE ? OR full_name LIKE ?', "%#{query}%", "%#{query}%")
  end

end
