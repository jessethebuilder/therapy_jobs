class Categorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :job
  belongs_to :user
end