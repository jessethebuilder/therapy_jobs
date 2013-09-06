class Contact < ActiveRecord::Base
  belongs_to :client
  has_many :job_form_sources

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  has_many :job_locations
  has_many :facilities, :through => :job_locations

  has_many :jobs
end
