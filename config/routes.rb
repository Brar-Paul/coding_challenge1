Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/upload', to: 'datas#upload', defaults: { format: :json }
end
