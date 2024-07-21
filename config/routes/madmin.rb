# Below are the routes for madmin
namespace :madmin do
  namespace :noticed do
    resources :events
  end
  namespace :noticed do
    resources :notifications
  end
  resources :announcements
  resources :services
  namespace :active_storage do
    resources :attachments
  end
  namespace :active_storage do
    resources :blobs
  end
  namespace :active_storage do
    resources :variant_records
  end
  resources :users
  root to: "dashboard#show"
end
