TherapyJobs::Application.routes.draw do
  devise_for :users

  resources :categories
  resources :job_search_criteria
  resources :facilities
  resources :clients
  resources :contacts
  resources :job_form_sources

  #get 'users/hook', :to => 'users#hook', :as => 'hook'

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
    end
  end

  root :to => 'jobs#index'
end
