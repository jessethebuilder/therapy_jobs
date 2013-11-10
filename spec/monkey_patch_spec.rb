require 'spec_helper'

describe 'monkey_patch.rb (in initializers)' do

  describe 'Array' do

    describe 'all_blank?' do
      it 'should return true if the array is empty' do
        [].all_blank?.should be_true
      end

      it 'should return true if all of its elements are blank' do
        ['','','','','','','', nil, nil, nil, nil].all_blank?.should be_true
      end

      it 'should return false otherwise' do
        ['','', nil, nil, 'VALUE'].all_blank?.should be_false
        ['VALUE', nil, ''].all_blank?.should be_false
        [nil, '', 'VALUE', nil, '' ].all_blank?.should be_false
      end
    end
  end

  describe 'ActiveRecord::Base' do
    describe ':match_on' do
      before(:all) do
        20.times{ create :address_with_data }
      end
      let(:this_city){ 'Nonsencical City 12@#$!' }
      let!(:j1){ create :address_with_data, :city => this_city}
      let!(:j2){ create :address_with_data, :city => this_city}
      let!(:j3){ create :address_with_data, :city => this_city}

      it 'should all records that match. Default is case_insensitive search' do
        j1.match_on(:city).count.should == 3
        j2.city = j2.city.downcase
        j2.save
        j1.match_on(:city).count.should == 3
        j1.match_on(:city, true).count.should == 2
      end
    end
  end
end