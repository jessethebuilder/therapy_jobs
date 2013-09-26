TherapyJobs::Application.routes.draw do
  devise_for :users
  get 'log_in', :to => 'users#log_in', :as => 'log_in'
  get 'sign_up', :to => 'users#sign_up', :as => 'sign_up'

  resources :categories
  resources :job_search_criteria
  resources :facilities
  resources :clients
  resources :contacts
  resources :job_form_sources

  resources :location_searches


  mount FarmAddress::Engine => "/address"

  resources :jobs do
    member do
      get 'apply', :to => 'jobs#apply', :as => 'apply'
    end
  end

  resources :job_forms, :only => [:create, :update] do
    collection do
      get ':name/(:code)', :to => 'job_forms#fill_out', :as => 'fill_out'

    end

    member do
      post 'process', :to => 'job_forms#process_form', :as => 'process'
      get 'reset', :to => 'job_forms#reset', :as => 'reset'
    end
  end

  root :to => 'jobs#index'
end
