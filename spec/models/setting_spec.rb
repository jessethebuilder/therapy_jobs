require 'spec_helper'

describe Setting do
  it{ should validate_presence_of :code }
  it{ should validate_presence_of :name }
  it{ should belong_to :setting_defined_for }
end