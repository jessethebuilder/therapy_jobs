require 'C:\Users\jf\Desktop\jesseweb\therapy_jobs\db\job_form_seed.rb'
include JobFormSeed

#Cats and Settings
SETTINGS.each do |k, v|
  Setting.create(:code => k, :name => v[:name] )
end

CATEGORIES.each do |k, v|
  Category.create(:code => k, :name => v[:name] )
end

address = Address.new(:street => '2829 Blue Springs Place',
                                     :city => 'Wesley Chapel', :state => 'fl', :zip => '33544')
client = Client.new(:name => 'Synergy Medical Staffing', :phone => '888-351-6628 x42')
client2 = Client.new(:name => 'Other Recruiting Company', :phone => '1234568779')
client2.addresses << address
client2.save
client.addresses << address
client.save
contact = Contact.create(:first_name => 'Jesse', :last_name => 'Farmer', :client_id => client.id,
                         :phone => '888-351-6628 x42', :email=> 'jfarmer@synergymedicalstaffing.com', :fax => '8883165861')
contact2 = Contact.create(:first_name => 'Jessica', :last_name => 'Farmer', :client_id => client2.id,
                          :phone => '8883516628 x43', :email=> 'jfarmer2@synergymedicalstaffing.com', :fax => '8883165861')

#100.times do |counter|
#  j = Job.new
#  Random.rand(0..1) == 1 ? j.duration_type = 'perm'
#  j.category = Category.first(:offset => rand(Category.count))
#  j.description = Faker::Lorem.paragraphs(paragraph_count = 2).join("\n\n")
#  j.benefits = ["Great Pay", "Great Friends", "Ethical", "Fun"].join("\n")
#  j.requirements = ["Great Attitude", "TB Test", "Other Stuff"].join("\n")
#  j.desirements = ["Even Better Attitude", "Management Experience", "Food Handler's Card"].join("\n")
#  j.zip_verified = true if Random.rand(1..2) == 1
#  j.required_experience = Random.rand(0..5)
#  j.desired_experience = Random.rand(0..10)
#  j.highlight = Faker::Lorem.paragraph(sentence_count = 2) unless counter == 1
#
#  this_contact = Contact.first(:offset => rand(Contact.count))
#  Random.rand(1..1).times do
#    f = Facility.new(:name => Faker::Company.name)
#    f.contact = this_contact
#    f.setting = Setting.first(:offset => rand(Setting.count))
#    f.description = Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..3)).join("\n\n")
#    f.address.city = Faker::Address.city
#    f.address.state = Address::STATES.keys.sample
#    f.address.zip = Faker::Address.zip_code
#    f.save
#    j.facilities << f
#  end
#  j.save
#end

  #############Users###################################
u = User.create(:email => 'test@test.com', :password => 'testtest')
  ######################### JobForm Migrations #############################################




jf = JobForm.new
jf.job_form_source = checklist_setup('pt')
jf.job_form_source.must_be_complete = true
jf.user = u
jf.save
