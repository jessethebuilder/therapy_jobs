require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module TherapyJobs
  class Application < Rails::Application
    #::SETTINGS = {'snf' => {:name => 'Skilled Nursing Facility', :setting => 'in a skilled nursing facility', :tj => 'Nursing Facility'},
    #              'acute' => {:name => 'Acute Care', :setting => 'in an acute care unit', :tj => 'Hospital'},
    #              'ip' => {:name => 'Inpatient Rehab', :setting => 'in an inpatient rehab unit', :tj => 'Hospital'},
    #              'op' => {:name => 'Outpatient', :setting => 'in an outpatient clinic', :tj => 'Outpatient'},
    #              'hosp' => {:name => 'Hospital', :setting => 'in a hospital', :tj => 'Hospital'},
    #              'hh' => {:name => 'Home Health', :setting => 'with a home health agency', :tj => 'Home Health'},
    #              'alf' => {:name => 'Assisted Living Facility', :setting => 'in an assisted living facility', :tj => 'Assisted Living Facility'},
    #              'ccrc' => {:name => 'Continuing Care Retirement Community', :setting => 'in a continuing care retirement facility', :tj => 'Assisted Living Facility'},
    #              'agency' => {:name => 'Agency', :setting => 'with an agency', :tj => 'Agency'}
    #             }
    #::CATEGORIES = {'pt' => {:name => 'Physical Therapist', :tj => 'Physical Therapy'},
    #            'ot' => {:name => 'Occupational Therapist', :tj => 'Occupational Therapy'},
    #            'slp' => {:name => 'Speech Language Pathologist', :tj => 'Speech Therapy'},
    #            'pta' => {:name => 'Physical Therapy Assistant', :tj => 'Physical Therapist Assistant'},
    #            'cota' => {:name => 'Certified Occupational Therapy Assistant', :tj => 'Certified Occupational Therapy Assistant'},
    #            'dor' => {:name => 'Director of Rehabilitation'},
    #            'rd' => {:name => 'Regional Director'},
    #            'pm' => {:name => 'Program Manager'}
    #}

    ::STANDARD_CATEGORIES = %w|pt ot slp pta cota|

    ::DURATION_TYPES = {'contract' => {:name => 'travel contract', :tj => 'Contract'},
                        'perm' => {:name => 'direct hire', :tj => 'Permanent'},
                        'prn' => {:name => 'PRN (coming soon)', :tj => 'PRN'}
                       }
    #::SUPER_SPLITTER = / ?[,;|-] ?/

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end

  ActiveSupport::Inflector.inflections do |inflect|
    inflect.irregular 'criterion', 'criteria'
  end
end
