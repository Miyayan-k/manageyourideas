require 'rails_helper'

RSpec.describe 'Ideas', type: :request do
  before do
    @idea_category = FactoryBot.build(:idea_category)
    @another_idea = FactoryBot.build(:idea_category)
  end

  describe 'POST /api/ver1/ideas' do
    context 'アイデアが登録できるとき' do
      it '正しくリクエストを送信すれば登録ができる' do
        post '/api/ver1/ideas', params: {
          category_name: @idea_category.category_name, body: @idea_category.body
        }
        expect(response.status).to eq(201)
      end
      it '同じカテゴリー名(test)でアイデアを登録したとき、categorysレコードは増えない' do
        # カテゴリー名"test"でアイデアを登録する
        @idea_category.category_name = 'test'
        expect do
          post '/api/ver1/ideas', params: {
            category_name: @idea_category.category_name, body: @idea_category.body
          }
        end.to change(Category, :count).by(+1)
        # 別のアイデアもカテゴリー名を"test"とし、登録するとCategorysレコードのカウントは増えない
        @another_idea.category_name = 'test'
        expect do
          post '/api/ver1/ideas', params: {
            category_name: @another_idea.category_name, body: @another_idea.body
          }
        end.to change(Category, :count).by(0)
      end
    end

    context 'アイデアが登録できないとき' do
      it 'category_nameが空では登録できない' do
        @idea_category.category_name =  ''
        post '/api/ver1/ideas', params: {
          category_name: @idea_category.category_name, body: @idea_category.body
        }
        expect(response.status).to eq(422)
      end
      it 'bodyが空では登録できない' do
        @idea_category.body = ''
        post '/api/ver1/ideas', params: {
          category_name: @idea_category.category_name, body: @idea_category.body
        }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET /api/ver1/ideas' do
    context 'アイデアを取得できるとき' do
      it 'リクエストを送信しない場合、全てのアイデアを取得できる' do
        # アイデアを2つ登録する。
        @idea_category.save
        @another_idea.save
        # リクエストでは、paramsを指定しない。
        get '/api/ver1/ideas'
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        # 取得されるアイデアは2つであることを確認する。
        expect(json.length).to eq(2)
      end
      it 'カテゴリー名(test)を指定すると該当のアイデアを取得できる' do
        # 登録するアイデアのうち、1つのアイデアのカテゴリー名を「test」とする。
        @idea_category.category_name = 'test'
        @idea_category.save
        @another_idea.save
        # 送信するリクエストで、カテゴリー名を「test」と指定する。
        get '/api/ver1/ideas', params: { category_name: 'test' }
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        # @another_ideaのFakerで「test」を返さない限り、返却されるアイデアは1つである。
        expect(json.length).to eq(1)
        # 返却されるアイデアのカテゴリー名は「test」であることを確認する。
        expect(json[0]['category_name']).to include('test')
      end
    end

    context 'アイデアが取得できないとき' do
      it '存在しないカテゴリー名を指定してリクエストを送信した場合、ステータスコード404を返す。' do
        @idea_category.save
        # Fakerでは日本語を生成しないため、日本語のカテゴリー名でリクエストを送信する。
        get '/api/ver1/ideas', params: { category_name: '存在しないカテゴリー名' }
        expect(response.status).to eq(404)
      end
    end
  end
end
