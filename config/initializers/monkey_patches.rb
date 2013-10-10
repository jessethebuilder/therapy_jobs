class Array
  def all_blank?
    blank = true
    self.each{ |item| blank = false unless item.blank? }
    blank
  end
end