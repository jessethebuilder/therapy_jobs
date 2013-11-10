require 'spec_helper'

describe ActiveRecordHelper do
  describe '#acts_like_an_array' do
    #relies on Job having #acceptable_categories as an 'acts_like_an_array' method
    let(:job){ create :job }
    it 'should save as an array' do
      job.acceptable_categories.should == []
      job.acceptable_categories = %w|test1 test2|
      job.acceptable_categories.should == ['test1', 'test2']
    end

    specify 'add + _method_name should all one to pass a value as an array or as a single value to acts_like_an_array attribute' do
      job.add_acceptable_categories('test1')
      job.acceptable_categories.should == ['test1']
      job.add_acceptable_categories(['test2', 'test3'])
      job.acceptable_categories.should == ['test1', 'test2', 'test3']
    end
  end
end