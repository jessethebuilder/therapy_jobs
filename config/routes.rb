TherapyJobs::Application.routes.draw do
  resources :quick_jobs do
    collection do

    end
  end

  resources :addresses do
    member do
      get 'map_to/(:address_string)', :to => 'addresses#map_to', :as => 'map_to'
    end
  end

  devise_for :users
  get 'log_in', :to => 'users#log_in', :as => 'log_in'
  get 'sign_up', :to => 'users#sign_up', :as => 'sign_up'


  resources :location_searches do
    collection do
      get 'radius_search/(:address_string)/(:search_radius)',
                        :to => 'location_searches#radius_search', :as => 'radius_search'
    end
  end

  resources :categories
  resources :job_search_criteria do
    collection do
      get 'search', :to => 'job_search_criteria#search', :as => 'search'
    end
  end

  resources :facilities
  resources :clients
  resources :contacts
  resources :job_form_sources

  resources :jobs do
    member do
      get 'apply', :to => 'jobs#apply', :as => 'apply'
      get 'flag', :to => 'jobs#flag', :as => 'flag'
    end

    collection do
      get 'tj', :to => 'jobs#tj', :as => 'tj'
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
