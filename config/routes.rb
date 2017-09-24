Rails.application.routes.draw do
  devise_for :users

  root "teams#index"

  get "/teams/:id" => "teams#index"
  get "/teams/:team_id/events" => "events#index"
  get "/teams/:team_id/events/loadmore" => "events#loadmore"
end
