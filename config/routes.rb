Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations], path: '', path_names: { sign_in: 'iniciar-sessao', sign_out: 'sair' }

  namespace :admin, path: 'administracao' do 
    root "products#index"
    resource :profile, only: [:edit, :update], path: 'perfil'
    resources :categories, path: 'categorias'
    resources :products, path: 'produtos'
  end

  root "home#index"
  resources :products, path: 'produtos', only: [:show]

  get 'quem-somos', to: 'home#who_we_are', as: 'who_we_are'

  get '/produtos/imagens/:id', to: 'application#product_image_show', as: 'product_image_show'
end
