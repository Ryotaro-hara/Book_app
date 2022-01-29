Rails.application.routes.draw do
  root 'home#index'
  # deviseのルーティング変更のためコントローラー作成
  devise_for :users, controllers: { registrations: 'users/registrations' }, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 



  # deviseのルーティング変更のためコントローラー作成
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  get 'users/show'

  resources :rooms do
    collection do
      get :search #検索機能
    end
  end
  
  resources :reservations do
    collection do
      get :complete #入力完了
    end
  end
end
