require 'spec_helper'

describe Facility do
  let(:facility){ build :facility }

  describe 'Validations' do

    it{ should validate_presence_of :setting }
    it{ should validate_presence_of :name }

    specify 'city must be present' do
      facility.should be_valid
      facility.address.city = nil
      facility.should_not be_valid
    end

    specify 'state must be present' do
      facility.address.city = nil
      facility.should_not be_valid
    end

    specify 'state must be a two letter code' do
      facility.address.state = 'some value'
      facility.should_not be_valid
      facility.address.state = 'ca'
      facility.should be_valid
    end

  end #Validations

  describe 'Associations' do
    it{ should have_many :jobs }
    it{ should belong_to :contact }
    it{ should have_one :address}
    it{ should belong_to :setting }

    describe '#address' do
      specify 'it should create an address before save' do
        facility.address.should_not be_nil
      end
    end
  end #Associations

  describe '===' do
    let(:f2){ facility.dup }
    before(:each){ f2.address = facility.address }

    it 'should compare facilities' do
      f2.should_not be_nil
      facility.===(f2).should be_true
      facility.contact = create :contact
      facility.===(f2).should be_false
    end
  end

end #spec