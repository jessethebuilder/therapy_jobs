require 'spec_helper'


describe Contact do
  let(:c){ build :contact }

  #it{ validates_uniqueness_of :email }
  #it{ validates_uniqueness_of :nickname }

  describe '#Contact.find_or_create_from_contact_string' do
    before(:all) do
      100.times { create :contact_with_data }
    end
    let!(:c2){ create :contact, :nickname => 'ss', :email => 'shawnspencer@test.com', :first_name => 'Shawn', :last_name => 'Spencer'}

    it 'should find Contact if :nickname matches (case inspecific)' do
      Contact.find_or_create_by_contact_string('Ss').should == c2
    end

    it 'should find Contact if emails match (case inspecific)' do
      Contact.find_or_create_by_contact_string('sHawnSpencer@test.coM').should == c2
    end

    it 'should find Contact if first and last names match (case inspecific)' do
      Contact.find_or_create_by_contact_string('shawn SPENCER').should == c2
      Contact.find_or_create_by_contact_string('Shawn Spencerson').should_not == c2
    end

    it 'should create a new contact if nothing matches' do
      nonsense = '1239kfdncii-0))+=1-..,;/.liuhhb'
      contact = Contact.find_or_create_by_contact_string(nonsense)
      contact.class.should == Contact
      contact.nickname.should == nonsense
      contact.should == Contact.last
    end
  end

end
