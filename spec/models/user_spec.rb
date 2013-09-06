require 'spec_helper'

describe User do
  let(:user){ build :user }

  specify 'factory' do
    user.should be_valid
  end

  describe 'Validations and Associations' do
    it{ should have_one :job_search_criterion }
  end #Validations and Associations

  #todo not sure how these scopes will work. maybe user/candidate and contact will be two different models w/ seperate authentication

  #describe '#candidates_scope' do
  #  it 'should return all candidates with "candidate" on #type' do
  #    expect{ create :candidate }.to change{ User.candidates.count }.by(1)
  #    expect{ create :user, :this_type => 'test_type' }.not_to change{ User.candidates.count }
  #  end
  #end

  describe '#job_serach_criterion' do
    it 'creates #job_search_critera on create' do
      expect{ user.save }.to change{ JobSearchCriterion.count }.by(1)
      user.job_search_criterion.should_not be_nil
    end
  end


end

