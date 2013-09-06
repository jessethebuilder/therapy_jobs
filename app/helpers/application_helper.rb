module ApplicationHelper
  include FarmTwitterBootstrap

  #todo clean up this mother brain stuff.
  def ApplicationHelper.mb
    @mother_brain ||= MotherBrain.first
  end

  def list_item_builder(list, deliminator = "\n")
    html = ''
    list.split(deliminator).each do |item|
      html += "<li>#{item}</li>"
    end if list
      html.html_safe
  end

    def display_contact(record)
    #record must have first_name, last_name, phone, email, and fax attributes
    html = "<p class='lead'>#{record.first_name.to_s} #{record.last_name.to_s}</p>"
    html += "<p><strong>#{number_to_phone(record.phone)}</strong><br>" unless record.phone.blank?
    html += "#{mail_to(record.email.to_s)}<br>" unless record.email.blank?
    html += "Fax: #{number_to_phone(record.fax.to_s)}</p>" unless record.fax.blank?
    html.html_safe
  end
end

class ActiveRecord::Base

  #mattr_reader :mb
  #def mb
  #  @mb ||= MotherBrain.first
  #end
  #
  #def self.hash_explained_attributes(*attrs)
  #  #todo spec this
  #  #convers between keys and values on a hash as long as attribute name matches an attribute name (pluralized)
  #  #in mother brain that is a hash.
  #  attrs.each do |attr|
  #    self.class_eval do
  #      collection_name = attr.to_s.pluralize.to_sym
  #
  #      define_method attr do
  #        mb.send(collection_name)[read_attribute(attr)]
  #      end
  #
  #      define_method "#{attr.to_s}=" do |val|
  #        if mb.send(collection_name).has_value?(val)
  #          write_attribute(attr, mb.send(collection_name).invert[val])
  #        else
  #          write_attribute(attr, val)
  #        end
  #      end
  #    end #class_eval
  #
  #    self.instance_eval do
  #      validates attr.to_sym, :inclusion => eval("ApplicationHelper.mb.#{attr.to_s.pluralize}.values")
  #    end
  #  end
  #end #hash_explained_attributes

end
