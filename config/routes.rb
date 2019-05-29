Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :mailchimp_settings do
      post "setup_store" => "mailchimp_settings#setup_store"

      get 'bulk_update_products' => 'mailchimp_settings#bulk_update_products'
    end
  end
end
