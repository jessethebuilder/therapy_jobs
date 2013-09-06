module CategoriesHelper

  def set_category(category_code)
    cats = Category.where(:code => category_code).first
    self.category = cats
    @cats = Category.all
    @count = Category.first
    self
  end
  
  def set_categories(*category_codes)
    self.categories << Category.where(:code => category_codes)
    self
  end

  def categories_for_select(all_categories = false)
    cats = []
    Category.standard.each do |cat|
      cats << [cat.name, cat.id]
    end
    if all_categories
      raise NotImplementedError, 'Implement this!'
    end
    options_for_select(cats)
  end


end
