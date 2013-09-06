class JobLocation < ActiveRecord::Base
  belongs_to :job
  belongs_to :facility
  belongs_to :contact
end