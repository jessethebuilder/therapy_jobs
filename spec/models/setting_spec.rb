require 'spec_helper'

describe Setting do
  it{ should validate_presence_of :code }
  it{ should validate_presence_of :name }
end