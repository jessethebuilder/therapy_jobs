class JobSearchCriterion < ActiveRecord::Base
  include Hacks

  belongs_to :user

  validates :user, :presence => true

  serialize :order_on, Hash
  serialize :search_on, Hash
  serialize :recent_jobs, Array

  serialize :states
  serialize :categories

  def search
    category_search
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
