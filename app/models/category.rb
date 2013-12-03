class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :jobs, :through => :categorizations

  has_many :job_form_sources

  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true

  scope :management, -> {where(:management => true) }
  scope :nonstandard, -> { where('code NOT IN (?)', STANDARD_CATEGORIES) }
  scope :standard, -> { where(:code => STANDARD_CATEGORIES) }

  def Category.find_by_code(code)
    self.where(:code => code)
  end

  def standard?
    STANDARD_CATEGORIES.include?(self.code) ? true : false
  end

end
