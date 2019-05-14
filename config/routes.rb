Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "index#index", as: :home

  namespace :api do
    namespace :restaurants do
      get "search"
    end
  end
end
