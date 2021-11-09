Rails.application.routes.draw do
  get 'html_pages/home'
  get 'html_pages/help'
  root 'application#hello'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
