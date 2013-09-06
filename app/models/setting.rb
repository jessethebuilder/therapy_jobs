class Setting < ActiveRecord::Base
  belongs_to :setting_defined_for, :polymorphic => true

  validates :code, :presence => true
  validates :name, :presence => true
end