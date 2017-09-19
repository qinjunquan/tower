Rails.application.routes.draw do
  devise_for :users

  root "teams#index"

  get "/teams/:id" => "teams#index"
  get "/teams/:id/events" => "events#index"
end
