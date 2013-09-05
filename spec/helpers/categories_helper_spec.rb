require 'spec_helper'

describe CategoriesHelper do
  let(:category){ create(:category, :code => 'tc', :name => 'Test Category') }

  describe '#set_category' do
    #Job has_one category
    let(:job){ create :job }

    it 'should associate a single category, on a has_one association, to the record' do
      category.code = 'tc'
      category.name = 'Test Category'
      job.set_category('tc')
      job.category.name.should == 'Test Category'
    end

    it 'should return self' do
      job.set_category('tc').should == job
    end
  end

  describe '#set_categories(category_code)' do
    #User has_many categories
    let(:user){ create :user }
    let(:category2){ create(:category, :code => 'tc2', :name => 'Test Category 2') }

    it 'should associate multiple records on a has_many relationship' do
      user.set_categories(['tc', 'tc2'])
      user.categories.count.should == 2
      user.categories.each { |cat| ['Test Category', 'Test Category 2'].include?(cat.name) }
    end

    it 'should work a list of codes' do
      user.set_categories('tc', 'tc2')
      user.categories.count.should == 2
      user.categories.each { |cat| ['Test Category', 'Test Category 2'].include?(cat.name) }
    end

    it 'should return self' do
      user.set_categories('tc').should == user
    end
  end #set_categories


end