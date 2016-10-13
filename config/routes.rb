Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'QRCode' ,to: 'qrcodes#index'
  get 'index' ,to: 'fb_post#index'
  get 'post' ,to: 'fb_post#post'

  root to: 'qrcodes#index'
end
