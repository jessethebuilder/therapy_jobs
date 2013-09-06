class Category < ActiveRecord::Base
  belongs_to :categorization, :polymorphic => true
  has_many :job_form_sources

  validates :code, :presence => true
  validates :name, :presence => true, :uniqueness => true

  scope :management, -> {where(:management => true) }
  scope :nonstandard, -> { where('code NOT IN (?)', STANDARD_CATEGORIES) }
  scope :standard, -> { where(:code => STANDARD_CATEGORIES) }

  def Category.find_by_code(code)
    self.where(:code => code)
  end
end
