FoxAppsRails::Application.routes.draw do

  resources :user_management

  match 'API10/jurisdiction_list', :controller => 'api10', :action => 'jurisdiction_list'
  match 'API10/jurisdiction_statute/:id', :controller => 'api10', :action => 'jurisdiction_statute'
  match 'API10/jurisdiction_statutes/:id', :controller => 'api10', :action => 'jurisdiction_statutes'
  match 'API10/content_pages/:name/get_all_page_blocks', :controller => 'api10', :action => 'get_all_page_blocks'

  get 'content_pages/', :controller => 'content_pages', :action => 'index'
  get 'content_pages/new', :controller =>'content_pages', :action => 'new'
  get 'content_pages/show/:id', :controller => 'content_pages', :action => 'show', :as => 'show_content_pages'
  get 'content_pages/edit/:id', :controller => 'content_pages', :action => 'edit', :as => 'edit_content_pages'
  post 'content_pages/create/', :controller => 'content_pages', :action => 'create_page', :as => 'create_content_pages'
  put 'content_pages/update/:id', :controller => 'content_pages', :action => 'update', :as => 'update_content_pages'
  delete 'content_pages/destroy/:id', :controller => 'content_pages', :action => 'destroy', :as => 'destroy_content_pages'

  get 'page_blocks/show/:id', :controller => 'page_blocks', :action => 'show', :as => 'show_page_blocks'
  get 'content_pages/:content_page_id/page_blocks/new', :controller => 'page_blocks', :action => 'new', :as => 'new_page_blocks'
  get 'page_blocks/edit/:id', :controller => 'page_blocks', :action => 'edit', :as => 'edit_page_blocks'
  post 'page_blocks/:content_page_id', :controller => 'page_blocks', :action => 'create', :as => 'create_page_blocks'
  delete 'page_content/show/:content_page_id/:id', :controller => 'page_blocks', :action => 'destroy', :as => 'destroy_page_blocks'

  get 'page_content/:content_page_id/page_block/new_block_person/', :controller => 'page_blocks', :action => 'new_block_person', :as => 'new_block_person'
  post 'content_pages/show/create_block_person', :controller => 'page_blocks', :action => 'create_block_person', :as => 'create_block_person'
  put 'content_pages/:content_page_id/page_block/update_block_person/:id', :controller => 'page_blocks', :action => 'update_block_person', :as => 'update_block_person'
  get 'page_content/:content_page_id/page_block/new_plain_text/', :controller => 'page_blocks', :action => 'new_block_plain_text', :as => 'new_block_plain_text'
  post 'content_pages/show/create_block_text', :controller => 'page_blocks', :action => 'create_block_text', :as => 'create_block_text'
  put 'content_pages/show/update_block_plain_text/:id', :controller => 'page_blocks', :action => 'update_block_plain_text', :as => 'update_block_plain_text'
  get 'content_pages/:content_page_id/page_block/:id/create_pic', :controller => 'page_blocks', :action => 'create_pic', :as => 'create_pic'
  put 'content_page/:content_page_id/page_block/:id/update_pic', :controller => 'page_blocks', :action => 'update_pic', :as => 'update_pic'

  get 'page_content/:content_page_id/move_up/:id', :controller => 'page_blocks', :action => 'move_up', :as => 'move_up_page_blocks'
  get 'page_content/:content_page_id/move_down/:id', :controller => 'page_blocks', :action => 'move_down', :as => 'move_down_page_blocks'


  resources :statute_types do
    resources :statutes
    resources :text_entries
  end

  match 'jurisdictions/geocode', :controller => 'jurisdictions', :action => 'geocode'
  resources :jurisdictions


  get "home/index"

  devise_for :users

  root :to => 'home#index'

end
