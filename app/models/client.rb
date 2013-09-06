class Client < ActiveRecord::Base
  has_many :contacts
  has_many :jobs
  has_many :job_form_sources

  has_many :addresses, :as => :addressable, :class_name => 'FarmAddress::Address'

  validates :name, :presence => true
  validates :phone, :presence => true

  has_attached_file :logo, :styles => {:medium => ['450x450>'], :medium_show => ["250x250>"]}
  validates_attachment_size :logo, :less_than => 1.megabyte
  #mount_uploader :image, ImageUploader

  def Client.dirty_factory
    client = self.new
    client.name = Faker::Company.name
    client.phone = Faker::PhoneNumber.phone_number
    client
  end
end
