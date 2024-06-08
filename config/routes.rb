Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post '/encode', to: 'urls#encode', as: :urls_encode
  post '/decode', to: 'urls#decode', as: :urls_decode
end
