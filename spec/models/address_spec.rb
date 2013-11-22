require 'spec_helper'

describe Address do
  let(:a){ create :address_with_data }
  describe '=== (case inspecific)' do
    let(:other_address){ a.dup }

    it 'should compare addresses loosely' do
      a.===(other_address).should be_true
      a.street = 'Jibberish Lane'
      a.===(other_address).should be_false

      a.street = other_address.street
      a.city = 'MoreJiberish123.993'
      a.===(other_address).should be_false
    end
  end

  describe '#matching_addresses' do
    #matching_addresses is dynamically created by #matchable in ActiveRecordHelper. This spec serves to test that
    #function as well.

  end
end
