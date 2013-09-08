class Setting < ActiveRecord::Base
  has_many :facilities

  validates :code, :presence => true
  validates :name, :presence => true
end