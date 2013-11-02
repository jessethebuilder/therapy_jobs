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
    ::SETTINGS = {'snf' => 'Skilled Nursing Facility',
                  'acute' => 'Acute Care',
                  'inpatient' => 'Inpatient Rehab',
                  'op' => 'Outpatient',
                  'hospital' => 'Hospital',
                  'hh' => 'Home Health',
                  'alf' => 'Assisted Living Facility',
                  'ccrc' => 'Continuing Care Retirement Community'
    }
    ::CATEGORIES = {'pt' => 'Physical Therapist',
                'ot' => 'Occupational Therapist',
                'slp' => 'Speech Language Pathologist',
                'pta' => 'Physical Therapy Assistant',
                'cota' => 'Certified Occupational Therapy Assistant',
                'dor' => 'Director of Rehabilitation',
                'rd' => 'Regional Director',
                'pm' => 'Program Manager'
    }

    ::STANDARD_CATEGORIES = %w|pt ot slp pta cota|

    ::DURATION_TYPES = ['Travel', 'Direct Hire', 'PRN (coming soon)']

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
