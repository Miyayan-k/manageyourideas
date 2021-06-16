class IdeaCategory
  include ActiveModel::Model
  attr_accessor :category_name, :body

  with_options presence: true do
    validates :category_name
    validates :body
  end

  def save
    ActiveRecord::Base.transaction do
      category = Category.find_or_create_by!(name: category_name)
      idea = Idea.create(body: body, category_id: category.id)
      idea.save!
    end
  end
end