Rails.application.routes.draw do
  # 今後のAPIバージョン管理を想定
  namespace 'api' do
    namespace 'ver1' do
      resources :ideas, only: [:index, :create]
    end
  end
end