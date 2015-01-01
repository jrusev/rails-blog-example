Rails.application.routes.draw do
  root 'welcome#index'

  # HttpMethod 'UrlRoute', to: 'Controller#Method', as: :PrefixShortname
  post '/articles/search', to: 'articles#search', as: :article_search

  resources :articles do
    resources :comments
  end
end
