class Array
  def all_blank?
    blank = true
    self.each{ |item| blank = false unless item.blank? }
    blank
  end
end

class ActiveRecord::Base
  def match_on(*attrs, case_sensitive = false)
    where_clauses = "self.class"
      attrs.each do |attr|
        where_clauses += ".where('#{attr.to_s} LIKE ?', '#{send(attr)}')"
      end
      eval(where_clauses)
    #end
  end
end