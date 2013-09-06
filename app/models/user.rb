class User < ActiveRecord::Base
  include CategoriesHelper
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validates :this_type, :presence => true, :inclusion => { :in => USER_TYPES }
  #validate :at_least_one_category

  has_many :job_forms

  has_many :categories, :as => :categorization
  has_one :job_search_criterion

  scope :candidates, -> { where(:type => 'candidate') }

  before_create do
    self.job_search_criterion = JobSearchCriterion.new
  end

  def jsc
    self.job_search_criterion
  end

  private

  def at_least_one_category
    errors.add(:categories, 'cant be blank') if self.categories.empty?
  end


end
