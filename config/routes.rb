Solar::Application.routes.draw do 

  devise_for :users, controllers: { registrations: "devise/users", passwords: "devise/users_passwords" }

  authenticated :user do
    get "/", to: "users#mysolar"
  end

  devise_scope :user do
    get  :login, to: "devise/sessions#new"
    post :login, to: "devise/sessions#create"
    get  :logout, to: "devise/sessions#destroy"
    get "/", to: "devise/sessions#new"
    resources :sessions, only: [:create]
  end

  get :home, to: "users#mysolar", as: :home
  get :tutorials, to: "pages#tutorials", as: :tutorials

  resources :users do
    member do
      get :photo
      put :update_photo
    end
    collection do
      get :edit_photo
      get :verify_cpf
      get :synchronize_ma
      get :profiles
      get :request_profile
    end
  end

  resources :social_networks, only: [] do
    collection do
      get :fb_authenticate
      get :fb_feed
      get :fb_logout  
      get :fb_post_wall
      get "fb_feed/group/:id", to: "social_networks#fb_feed_groups", as: :fb_feed_group
      get "fb_feed/group/:id/news", to: "social_networks#fb_feed_group_news", as: :fb_feed_group_new
      get :fb_feed_new
    end
  end

  scope "/admin" do
    resources :profiles do
      get :permissions, on: :member
      put "permissions/grant", to: :grant, on: :member
    end

    get "allocations/:id", to: "administrations#show_allocation", as: :admin_allocation
    get "allocations/:id/edit", to: "administrations#edit_allocation", as: :edit_admin_allocation
    put "allocations/:id", to: "administrations#update_allocation"

    get "users/search", to: "administrations#search_users", as: :search_admin_users
    get "users/:id", to: "administrations#show_user", as: :admin_user
    put "users/:id", to: "administrations#update_user"
    put "users/:id/password", to: "administrations#reset_password_user", as: :reset_password_admin_user
    get "users/:id/edit", to: "administrations#edit_user", as: :edit_admin_user
    get "users/:id/allocations", to: "administrations#allocations_user", as: :allocations_admin_user
    get "users", to: "administrations#users", as: :admin_users
    
    get "responsibles/filter", to: "administrations#responsibles", as: :admin_responsibles_filter
    get "responsibles", to: "administrations#responsibles_list", as: :admin_responsibles

    # get "users", to: "administrations#users_indication", as: :users_indication

    ## logs
    get :logs, to: "administrations#logs", as: :logs
    get "logs/type/:type", to: "administrations#search_logs", as: :search_logs

    ## import users

    get "/import/users/filter", to: "administrations#import_users", as: :import_users_filter
    get "/import/users/form", to: "administrations#import_users_form", as: :import_users_form
    post "/import/users/batch", to: "administrations#import_users_batch", as: :import_users_batch
    get "/import/users/log/:file", to: "administrations#import_users_log", as: :import_users_log
  end

  resources :administrations do
    collection do
      get :users_indication
      get :allocation_approval
      get :search_allocation, action: :allocation_approval, defaults: {search: true}
      get :lessons
    end
  end

  ## curriculum_units/:id/participants
  ## curriculum_units/:id/informations
  resources :curriculum_units do
    collection do 
      get :list
      get :mobilis_list
      get :list_informations
      get :list_participants
      get :list_combobox, to: :index, combobox: true, as: :list_combobox

      get :participants
      get :informations
    end
    member do
      get :home
    end
    resources :groups, only: [:index] do
      collection do 
        get :mobilis_list
      end
    end
  end

  ## groups/:id/discussions
  resources :groups, except: [:show] do
    resources :discussions, only: [:index] do
      collection do 
        get :mobilis_list, to: :index, mobilis: true
      end
    end  
    get :list, on: :collection
    get :list_to_edit, to: :list, on: :collection, edition: true
    get :academic_index, on: :collection
  end

  ## discussions/:id/posts
  resources :discussions do
    collection do
      get :list
      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "Discussion", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "Discussion", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "Discussion", as: :add_group_to
    end
    resources :posts, except: [:show, :new, :edit] do
      collection do
        get "user/:user_id", to: :show, as: :user
        get ":type/:date(/order/:order(/limit/:limit))", to: :index, defaults: {display_mode: 'list'} # :types => [:news, :history]; :order => [:asc, :desc]
      end
    end
  end

  ## posts/:id/post_files
  resources :posts, only: [:index] do
    resources :post_files, only: [:new, :create, :destroy, :download] do
      get :download, on: :member
      get :api_download, on: :member
    end
  end

  ## allocations/enrollments
  resources :allocations, except: [:new] do
    collection do
      get :designates
      get :admin_designates, action: :designates, defaults: {admin: true}
      get :enrollments, action: :index
      get :search_users
      post :create_designation
      post :request_designation, to: :create_designation, defaults: {request: true}
    end
    member do
      delete :cancel, action: :destroy
      delete :cancel_request, action: :destroy, defaults: {type: 'request'}
      delete :cancel_profile_request, action: :destroy, defaults: {type: 'request', profile: true}

      post :reactivate
      put :deactivate
      put :activate
      put :reject, action: :accept_or_reject, defaults: {accept: false}
      put :accept, action: :accept_or_reject, defaults: {accept: true}
      put :undo_action, action: :accept_or_reject, defaults: {undo: true}
    end
  end

  resources :semesters, except: [:show] do
    get :list_combobox, to: :index, combobox: true, as: :list_combobox, on: :collection
    resources :offers, only: [:index, :new]
  end

  resources :offers, except: [:new] do
    post :deactivate_groups, on: :member
    get :list, on: :collection
  end

  resources :scores, only: [:index] do
    collection do
      get :info
      get "student/:student_id/info", to: :student_info, as: :student_info

      get :amount_history_access
    end
    get :history_access, on: :member
  end

  resources :edx_courses, only: [:index, :new] do
    collection do
      post :create, as: :create
      post "delete/:course", to: :delete, as: :delete
      get :my
      get :available
      post "enroll/:course", to: :enroll, as: :enroll
      post "unenroll/:course", to: :unenroll, as: :unenroll
      get :content
      get :search_users
      get :items
      get "designates/:course", to: :designates, as: :designates
      post "allocate/:username/:course/:profile", to: :allocate, as: :allocate
      post "deallocate/:username/:course/:profile", to: :deallocate, as: :deallocate
    end
  end

  resources :enrollments, only: :index do
    collection do
      get ":group_id", to: :show, as: :group
      get :public_course, action: :show, defaults: {public: true}
    end
  end

  resources :courses do 
    get :list_combobox, to: :index, combobox: true, as: :list_combobox, on: :collection
  end

  resources :editions, only: [] do
    collection do
      get :items
      get :academic
      get :content
      get "academic/:curriculum_unit_type_id/courses", to: "editions#courses", as: :academic_courses
      get "academic/:curriculum_unit_type_id/curriculum_units", to: "editions#curriculum_units", as: :academic_uc
      get "academic/:curriculum_unit_type_id/semesters", to: "editions#semesters", as: :academic_semesters
      get "academic/:curriculum_unit_type_id/groups", to: "editions#groups", as: :academic_groups
      get "academic/:curriculum_unit_type_id/edx_courses", to: "editions#edx_courses", as: :academic_edx_courses
    end
  end

  resources :lessons do
    member do
      put "change_status/:status", to: :change_status, as: :change_status
      put "responsible_change_status/:status", to: :change_status, as: :responsible_change_status, defaults: {responsible: true}
      put "order/:change_id", action: :order, as: :change_order
      put :change_module
      get :edition, action: :show, defaults: {edition: true}
    end
    collection do
      get :list, action: :list
      get :download_files
      get :verify_download
      get :get_lessons, as: :get
    end
    resources :files, controller: :lesson_files, except: [:index, :show, :update, :create] do
      collection do
        get "extract/:file", to: :extract_files, as: :extract, constraints: { file: /.*/ }
        post :folder, to: :new, defaults: {type: 'folder'}, as: :new_folder
        post :file, to: :new, defaults: {type: 'file'}, as: :new_file
        put :rename_node, to: :edit, defaults: {type: 'rename'}
        put :move_nodes, to: :edit, defaults: {type: 'move'}
        put :upload_files, to: :new, defaults: {type: 'upload'}, as: :upload
        put :define_initial_file, to: :edit, defaults: {type: 'initial_file'}, as: :initial_file
        delete :remove_node, to: :destroy
      end
    end
  end
  get :lesson_files, to: "lesson_files#index", as: :lesson_files

  resources :assignments do
    collection do
      get :student_view
      get :professor

      get :download_files
      get "download_public_files/:file_id", to: :download_public_files, as: :download_public_files
      get :send_public_files_page

      post :upload_file
      delete :delete_file

      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "Assignment", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "Assignment", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "Assignment", as: :add_group_to
    end
    member do
      get :information
      get :import_groups_page
      get :student
      post :evaluate
      post :send_comment
      post :manage_groups
      post :import_groups
      delete :remove_comment
    end
  end

  # chat
  resources :chat_rooms do
    collection do
      get :list
      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "ChatRoom", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "ChatRoom", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "ChatRoom", as: :add_group_to
    end
  end

  resources :agendas, only: [:index] do
    collection do
      get :list
      get :calendar
      get :events

      resources :assignment, only: [] do
        get "/:allocation_tags_ids", to: "agendas#dropdown_content", type: "Assignment", as: :dropdown_content_of, on: :member
      end
      resources :discussion, only: [] do
        get "/:allocation_tags_ids", to: "agendas#dropdown_content", type: "Discussion", as: :dropdown_content_of, on: :member
      end
      resources :chat_room, only: [] do
        get "/:allocation_tags_ids", to: "agendas#dropdown_content", type: "ChatRoom", as: :dropdown_content_of, on: :member
      end
      resources :schedule_event, only: [] do
        get "/:allocation_tags_ids", to: "agendas#dropdown_content", type: "ScheduleEvent", as: :dropdown_content_of, on: :member
      end
    end
  end

  resources :schedule_events, except: [:index]

  resources :messages, only: [:new, :show, :create, :index] do
    member do
      put ":box/:new_status", to: "messages#update", as: :change_status, constraints: {box: /(inbox)|(outbox)|(trashbox)/, new_status: /(read)|(unread)|(trash)|(restore)/}

      get :reply,     to: :reply, type: "reply"
      get :reply_all, to: :reply, type: "reply_all"
      get :forward,   to: :reply, type: "forward"
    end

    collection do
      put ":id", to: :create

      get :index,                    box: "inbox"
      get :inbox,    action: :index, box: "inbox",    as: :inbox
      get :outbox,   action: :index, box: "outbox",   as: :outbox
      get :trashbox, action: :index, box: "trashbox", as: :trashbox
      get :count_unread
      get :find_users

      get "download/file/:file_id", to: "messages#download_files", as: :download_file

      get :support_new, to: "messages#new", as: :support_new, support: true
    end
  end

  resources :lesson_modules, except: [:index, :show] do
    collection do
      get :list
      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "LessonModule", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "LessonModule", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "LessonModule", as: :add_group_to
    end
  end

  # resources :tabs, only: [:show, :create, :destroy]
  get :activate_tab, to: "tabs#show", as: :activate_tab
  get :add_tab, to: "tabs#create", as: :add_tab
  get :close_tab, to: "tabs#destroy", as: :close_tab

  resources :support_material_files do
    collection do
      get :list
      get "at/:allocation_tag_id/download", to: :download, type: :all, as: :download_all
      get "at/:allocation_tag_id/folder/:folder/download", to: :download, type: :folder, as: :download_folder
      get "at/download", to: :download, type: :all, as: :download_all
      get "at/folder/:folder/download", to: :download, type: :folder, as: :download_folder
      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "SupportMaterialFile", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "SupportMaterialFile", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "SupportMaterialFile", as: :add_group_to
    end
    get :download, on: :member
  end

  resources :bibliographies, except: [:new, :show] do
    collection do
      get :list # edicao

      get :new_book           , to: :new, type_bibliography: Bibliography::TYPE_BOOK
      get :new_periodical     , to: :new, type_bibliography: Bibliography::TYPE_PERIODICAL
      get :new_article        , to: :new, type_bibliography: Bibliography::TYPE_ARTICLE
      get :new_electronic_doc , to: :new, type_bibliography: Bibliography::TYPE_ELECTRONIC_DOC
      get :new_free           , to: :new, type_bibliography: Bibliography::TYPE_FREE

      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "Bibliography", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "Bibliography", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "Bibliography", as: :add_group_to
    end
  end

  resources :notifications do
    collection do
      get :list # edicao

      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "Notification", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "Notification", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "Notification", as: :add_group_to
    end
  end

  resources :webconferences, except: :show do
    collection do
      get :list

      put ":tool_id/unbind/group/:id" , to: "groups#change_tool", type: "unbind", tool_type: "Webconference", as: :unbind_group_from
      put ":tool_id/remove/group/:id" , to: "groups#change_tool", type: "remove", tool_type: "Webconference", as: :remove_group_from
      put ":tool_id/add/group/:id"    , to: "groups#change_tool", type: "add"   , tool_type: "Webconference", as: :add_group_to
    end
  end

  get "/media/lessons/:id/:file.:extension", to: "access_control#lesson", index: true
  get "/media/lessons/:id/:folder/*path", to: "access_control#lesson", index: false

  get "/media/users/:user_id/photos/:style.:extension", to: "access_control#users"

  # get "/media/messages/:file.:extension", to: "access_control#message"
  get "/media/assignment/sent_assignment_files/:file.:extension", to: "access_control#assignment"
  get "/media/assignment/comments/:file.:extension", to: "access_control#assignment"
  get "/media/assignment/public_area/:file.:extension", to: "access_control#assignment"
  get "/media/assignment/enunciation/:file.:extension", to: "access_control#assignment"

  # IM
  # resources :instant_messages, only: [] do
  #   collection do
  #     get :prebind
  #   end
  # end

  mount Ckeditor::Engine => "/ckeditor"
  ## como a API vai ser menos usada, fica mais rapido para o solar rodar sem precisar montar essas rotas
  mount ApplicationAPI => '/api'

  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

end
