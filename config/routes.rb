Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :mailchimp_settings do
      post "setup_store" => "mailchimp_settings#setup_store"
    end
  end
end
