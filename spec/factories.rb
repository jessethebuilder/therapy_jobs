FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@test.com" }
  sequence(:first_name){ |n| "first_name#{n}" }
  sequence(:last_name){ |n| "last_name#{n}" }
  sequence(:name) { |n| "name#{n}" }
  sequence(:nickname){ |n| "nickname#{n}" }
  sequence(:code) { |n| "code#{n}" }

  factory :job_form_source do
    name
    contact
  end

  factory :job_form do
    job_form_source
  end

  factory :job do
    category
    contact
    duration_type DURATION_TYPES.keys.sample

    after(:build, :create) do |job, evaluator|
      job.facilities << create(:facility)
    end

    factory :standard_job do
      after(:build, :create) do |job, evaluator|
        job.category = create(:standard_category)
      end
    end

    factory :management_job do
      after(:build, :create) do |job, evaluator|
        job.category = create(:management_category)
      end
    end
  end

  factory :category do
    code
    name

    factory :standard_category do
      code STANDARD_CATEGORIES.sample


      after(:build, :create) do |category, evaluator|
        category.name = CATEGORIES[category.code][:name]
      end
    end

    factory :management_category do
      management true
    end
  end

  factory :facility do
    name Faker::Company.name
    contact
    setting

    after(:build, :create) do |facility, evaluator|
      #facility.address.street = Faker::Address.street_address
      facility.address.city = Faker::Address.city
      facility.address.state = facility.address.class::STATES.keys.sample
    end
  end

  factory :address do

    factory :address_with_data do
      street Faker::Address.street_address
      city Faker::Address.city
      state Address::STATES.keys.sample
      zip Faker::Address.zip
    end
  end

  factory :client do
    name Faker::Company.name
    phone Faker::PhoneNumber.phone_number

    factory :client_with_jobs do
      ignore do
        contact_count = 2
        jobs_per_contact = 10
      end

      after(:build, :create) do |client, evaluator|
        evaluator.contact_count.each do
          c = create :contact
          evaluator.jobs_per_contact.each do
          end
        end
      end
    end

  end #job

  factory :contact do
    #first_name Faker::Name.first_name
    #last_name Faker::Name.last_name
    #client

    factory :contact_with_data do
      first_name
      last_name
      nickname
      email
    end

    factory :contact_with_facilities do
      ignore do
        facility_count 3
      end

      after(:build, :create) do |contact, evaluator|
        evaluator.facility_count.times do
          contact.facilities << build(:facility, :contact => nil)
        end
      end
    end

  end #contact



  factory :setting do
    code
    name
  end

  factory :user do
    email
    password 'password'
    this_type USER_TYPES.sample

    factory :candidate do
      this_type 'candidate'
    end

    after(:build, :create) do |user, evaluator|
      user.categories << FactoryGirl.create(:category)
    end

  end

  factory :job_search_criterion do
    user
  end
end