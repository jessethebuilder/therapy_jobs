class JobFormSource < ActiveRecord::Base
  DEL = '!!-jfx-!!'
  SUB_DEL = ';;;'
  MODES = %w|rbg|

  belongs_to :client
  belongs_to :contact
  belongs_to :category

  has_many :job_forms

  validates :name, :presence => true
  validates :contact, :presence => true

  before_save do
    self.client_id = self.contact.client_id
  end


end
