class User < ActiveRecord::Base
  include CategoriesHelper
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :job_forms

  has_many :categories, :as => :categorization

  has_one :job_search_criterion, :dependent => :destroy

  scope :candidates, -> { where(:type => 'candidate') }

  before_create do
    self.job_search_criterion = JobSearchCriterion.new
  end

  def jsc
    self.job_search_criterion
  end

  private
end
