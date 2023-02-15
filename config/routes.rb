Rails.application.routes.draw do
  get '/cues/search', to: 'cues#index'
end
