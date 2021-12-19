Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Main route
  root '/'                           , action: :index             , controller:'healthchecks'

  # Bookmarks routes
  get    '/bookmarks'                , action: :index             , controller: 'bookmarks'
  post   '/bookmarks'                , action: :create            , controller: 'bookmarks'
  get    '/bookmarks/:id'            , action: :show              , controller: 'bookmarks'
  put    '/bookmarks/:id'            , action: :update            , controller: 'bookmarks'
  delete '/bookmarks/:id'            , action: :delete            , controller: 'bookmarks'

  # Sites routes
  get    '/sites'                    , action: :index             , controller: 'sites'

end
