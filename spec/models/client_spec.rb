require 'spec_helper'

describe Client do

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :phone }
  end


end
