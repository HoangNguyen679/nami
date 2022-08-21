Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  authenticate :user do
    resources :timelines, only: %i[index show], param: :username
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
