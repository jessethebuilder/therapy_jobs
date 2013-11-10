module Sandbox
  def self.seed_quick_jobs
    q = QuickJob.new(:specialty => 'cota', :setting_type => 'snf', :job_type => 'travel')
    add_known_address_to(q)
    q.save
  end

  def self.add_known_address_to(address_object)
    address_object.street = '4218 Mt. Angeles Rd'
    address_object.city = 'Port Angeles'
    address_object.state = "wa"
    address_object.zip = "98362"
    address_object
  end
end