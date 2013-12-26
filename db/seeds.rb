require "#{Rails.root}/db/job_form_seed.rb"
include JobFormSeed

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

j = Job.new(
  :duration_type => DURATION_TYPES.keys.sample,
)
j.category = Category.where(:code => CATEGORIES.keys.sample)
j.contact = c
j.save!

#############Users###################################
u = User.create(:email => 'test@test.com', :password => 'testtest')
######################### JobForm Migrations #############################################

jf = JobForm.new
jf.job_form_source = checklist_setup('pt')
jf.job_form_source.must_be_complete = true
jf.user = u
jf.save
