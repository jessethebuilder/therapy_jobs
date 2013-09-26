class JobSearchCriterion < ActiveRecord::Base
  include Hacks

  belongs_to :user
  #todo spec
  has_many :location_searches, :dependent => :destroy

  serialize :order_on, Hash
  serialize :search_on, Hash
  serialize :recent_jobs, Array

  serialize :states, Array
  serialize :categories, Array
  serialize :settings, Array

  def search
    category_search
  end



  def self.delete_abandoned
    #todo spec
    self.where("user_id = ?", nil).where("updated_at > ?", 3.days.ago).delete_all
  end

  private

  def category_search
    category_codes = self.search_on[:category]
    if self.include_management
      Category.management.each { |category| category_codes << category.code }
    end
    Job.with_these_categories(category_codes)
  end

end
