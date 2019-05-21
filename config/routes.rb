require 'api_constraints'

Rails.application.routes.draw do
  # Use for login and autorize all resource
  use_doorkeeper
  
  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
      }, skip: [:sessions, :password]
      resources :users, only: [:show, :update]
    end
  end
end
