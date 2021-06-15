Rails.application.routes.draw do
  namespace 'api' do
    namespace 'ver1' do
      resources  :categories
      resources :ideas
    end
  end
end