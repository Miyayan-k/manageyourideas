module Api
  module Ver1
    class IdeasController < ApplicationController
      def index
        @ideas = Idea.all
        render json: @ideas
      end

      def new
        @idea_category = IdeaCategory.new
      end

      def create
        @idea_category = IdeaCategory.new(idea_params)
        if @idea_category.valid?
          @idea_category.save
          render json: { status: 201, message: 'アイデアの登録に成功しました。', data: @idea_category }
        else
          render json: { status: 422, message: 'アイデアの登録に失敗しました。', data: @idea_category.errors }
        end
      end

      private
      def idea_params
        params.permit(:category_name, :body, :idea )
      end
    end
  end
end