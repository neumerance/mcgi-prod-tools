Rails.application.routes.draw do
  get '/cues/generate', to: 'cues#generate'
  get '/cues', to: 'cues#index'
  get '/cues/:id', to: 'cues#show'
end
