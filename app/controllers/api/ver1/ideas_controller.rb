module Api
  module Ver1
    class IdeasController < ApplicationController
      before_action :idea_params, only: :index

      # GET
      def index
        # カテゴリー名を指定しているか否か
        if params.include? 'category_name'
          @category = Category.find_by(name: params[:category_name])
          # 登録されているカテゴリーのリクエストであるか否か
          if @category.nil?
            render status: 404, json: { status: 404, message: 'お探しのカテゴリー名に該当するアイデアは見つかりませんでした。' }
          else
            @ideas = Idea.joins(:category).where(category_id: @category.id).select('ideas.id, name as category_name, body')
            render json: @ideas
          end
          # /登録されているカテゴリーのリクエストか否か
        else
          @ideas = Idea.joins(:category).select('ideas.id, name as category_name, body')
          render json: @ideas
        end
        # /カテゴリー名を指定しているか否か
      end

      # POST
      def create
        @idea_category = IdeaCategory.new(idea_params)
        if @idea_category.valid?
          @idea_category.save
          render status: 201, json: { status: 201, message: 'アイデアの登録に成功しました。', data: @idea_category }
        else
          render status: 422, json: { status: 422, message: 'アイデアの登録に失敗しました。', data: @idea_category.errors.full_messages }
        end
      end

      private
      def idea_params
        params.permit(:category_name, :body)
      end
    end
  end
end