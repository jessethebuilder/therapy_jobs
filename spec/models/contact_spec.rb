require 'spec_helper'

describe Contact do

  describe 'Validations' do
    let(:c){ Contact.new }

    it 'validates first and last name' do
      c.should_not be_valid
      c.valid?
      c.errors[:first_name].should_not be_nil
      c.errors[:last_name].should_not be_nil
      c.first_name = Faker::Name.first_name
      c.last_name = Faker::Name.last_name
      c.valid?
      c.errors[:first_name].count.should == 0
      c.errors[:last_name].count.should == 0
    end

    it 'validates client_id' do
      c.valid?
      c.errors[:client].should_not be_nil
      client = create :client
      c.client = client
      c.errors[:client].count.should == 0
    end

  end

end
