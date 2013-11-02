class JobSearchCriterion < ActiveRecord::Base
  include Hacks

  belongs_to :user
  #todo spec
  has_many :location_searches, :dependent => :destroy
  accepts_nested_attributes_for :location_searches


  serialize :order_on, Hash
  serialize :search_on, Hash
  serialize :recent_jobs, Array

  serialize :states, Array
  serialize :categories, Array
  serialize :settings, Array
  serialize :duration_types, Array


  def all_search
    records = JobSearchCriterion.mega_join
    records = self.category_search(records)
    records = self.state_search(records)
    records = self.setting_search(records)
    records = self.duration_type_search(records)
    records
  end



  def category_search(records)
    all_categories = self.categories
    all_categories << Category.nonstandard.collect{ |cat| [cat.code] } if self.include_management?
    query_records = records.where(:categories => {:code => all_categories}) unless self.categories.all_blank?
    query_records || records
  end

  def state_search(records)
    query_records = records.where(:addresses => {:state => self.states}) unless self.states.all_blank?
    query_records || records
  end

  def setting_search(records)
    query_records = records.where(:settings => {:code => self.settings}) unless self.settings.all_blank?
    query_records || records
  end

  def duration_type_search(records)
    query_records = records.where(:duration_type => self.duration_types) unless self.duration_types.all_blank?
    query_records || records
  end



  def self.delete_abandoned
    #todo spec
    self.where("user_id = ?", nil).where("updated_at > ?", 3.days.ago).delete_all
  end

  private

  def self.mega_join
    Job.joins(:facilities => :address).joins(:facilities => :setting).joins(:category)
  end
end
