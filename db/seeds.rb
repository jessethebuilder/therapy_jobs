require "#{Rails.root}/db/job_form_seed.rb"
include JobFormSeed

require "#{Rails.root}/app/helpers/hacks.rb"

#Cats and Settings
SETTINGS.each do |k, v|
  Setting.create(:code => k, :name => v[:name], :setting_clause => v[:setting])
end

CATEGORIES.each do |k, v|
  Category.create(:code => k, :name => v[:name], :profession => v[:profession] )
end

cl = Client.new(:name => 'Real Therapy Jobs')
cl.save!

c = Contact.new(
  :first_name => 'Jesse',
  :last_name => 'Farmer',
  :email => 'info@realtherapyjobs.com',
  :nickname => 'jessefarmer',
  :phone => '360-670-9312'
  )
c.client = cl
c.save!

50.times do
  j = Job.new(
    :duration_type => DURATION_TYPES.keys.sample,
    :description => Faker::Lorem.sentences(sentence_count = Random.rand(1..4)).join("\n")
  )
  f = Facility.new(:name => Faker::Company.name)
  f.setting = Setting.where(:code => SETTINGS.keys.sample).first
  a = Address.new(:street => Faker::Address.street_address,
                  :city => Faker::Address.city,
                  :state => Address::STATES.keys.sample,
                  :zip => Faker::Address.zip)
  f.address = a
  f.save!
  j.facilities << f
  j.category = Category.where(:code => CATEGORIES.keys.sample).first
  j.contact = c
  j.duration_type = DURATION_TYPES.keys.sample
  j.requirements = BoilerPlates.requirements(j)
  j.benefits = BoilerPlates.benefits(j)
  j.desirements = BoilerPlates.desirements(j)
  j.valid?
  @m=  j.errors.messages
  j.save!
end

#############Users###################################
u = User.create(:email => 'test@test.com', :password => 'testtest')
######################### JobForm Migrations #############################################

jf = JobForm.new
jf.job_form_source = checklist_setup('pt')
jf.job_form_source.must_be_complete = true
jf.user = u
jf.save!
