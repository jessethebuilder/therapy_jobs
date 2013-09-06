require 'spec_helper'

describe Category do
  it{ should validate_presence_of :code }
#  it{ should validate_uniqueness_of :code }
  it{ should validate_presence_of :name }

  let!(:category){ create :category }
  let!(:standard_category){ create :standard_category }
  let!(:management_category){ create :management_category }

  describe 'Scopes' do
    describe '#management' do
      it 'returns all categories for which management is true' do
        management = Category.management
        management.count.should.should == 1
        management.first.should == management_category
      end
    end

    describe '#nonstandard' do
      it 'returns all categories that are not pt, ot, slp, pta, cota' do
        ns = Category.nonstandard
        ns.count.should == 2
        #ns.include?(:category).should == true
        #ns.include?(:management_category).should == true
      end
    end

    describe '#standard' do
      it 'returns the main 5' do
        standard = Category.standard
        standard.count.should == 1
        STANDARD_CATEGORIES.include?(standard.first.code)
      end
    end

  end

end
