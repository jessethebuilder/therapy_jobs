module HashExplainedAttributesHelper
  mattr_accessor :mb

  def mb
    @mb ||= MotherBrain.first
  end

  def text_and_tip(record, attr, transformer_method = nil)
    attr_val = record.read_attribute(attr).to_s
    transformed_attr_val = transformer_method ? attr_val.send(transformer_method) : attr_val
    collection_name = attr.to_s.pluralize.to_sym
    "<div data-toggle='tooltip' title='#{mb.send(collection_name)[attr_val]}'>#{transformed_attr_val}</div>".html_safe
  end
end
