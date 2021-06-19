require 'rails_helper'

RSpec.describe IdeaCategory, type: :model do
  before do
    @idea_category = FactoryBot.build(:idea_category)
  end
  describe 'アイデア登録できるとき' do
    it 'カテゴリー名(category_name)と本文(body)を送信すれば登録ができる。' do
      expect(@idea_category).to be_valid
    end
  end

  describe 'アイデア登録ができないとき' do
    it 'カテゴリー名(category_name)が空では登録できない。' do
      @idea_category.category_name = ''
      @idea_category.valid?
      expect(@idea_category.errors.full_messages).to include("Category name can't be blank")
    end
    it '本文(body)が空では登録できない。' do
      @idea_category.body = ''
      @idea_category.valid?
      expect(@idea_category.errors.full_messages).to include("Body can't be blank")
    end
  end
end
