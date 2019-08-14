Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :hierarchy, only: [:index, :show, :create] do
        get :staff, on: :collection  
      end
    end
  end
end
