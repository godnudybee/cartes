Rails.application.routes.draw do
  get 'tst/retour'
  post 'retour', to: 'tst#retour'

  post 'verify_credentials', to: 'users#verify_credentials'
  post 'create_user', to: 'users#create'

  post 'envoi_otp', to: 'otps#envoi_otp'
  post 'verify_otp', to: 'otps#verify_otp'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
