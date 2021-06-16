class IdeaCategory
  include ActiveModel::Model
  attr_accessor :category_name, :body

  
  with_options presence: true do
    validates :category_name, uniqueness: true
    validates :body
  end

  def save
    ActiveRecord::Base.transaction do
      category = Category.find_or_created_by!(name: category_name)
      idea = Idea.create(body: body, category_id: category.id)
      idea.save!
    end
  end
end