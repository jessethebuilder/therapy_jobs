require 'spec_helper'

describe LocationSearch do
  let(:loc){ build :location_search }

  describe 'Validations' do
    it{ should validate_presence_of :search_radius }
    it{ should validate_numericallity_of :search_radius }

    describe '#address_string validations' do
      specify 'address_string should geocode' do
        loc.address.address_string = nil
        loc.valid?.should be_false
        loc.errors[:address].should include(/Location required/)
      end

      specify 'address_string should geocode' do
        ugly_string = '$%&.fkk3,xoio490-jgn'
        loc.address.address_string = ugly_string
        expect.valid?.should be_false
        loc.errors[:address].should include(/Could not locate #{ugly_string}/)
      end
    end

  end

  describe 'Associations' do
    it{ should accept_nested_attributes_for :address }
  end

  it 'should create an addresses upon initialization' do
    location_search = Location.new
    location.address.class.should == Address
  end
end
