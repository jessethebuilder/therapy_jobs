require 'spec_helper'

describe JobSearchCriterion do

  describe 'Validations and Associations' do
    it{ should belong_to :user }
  end

  let(:jsc){ build :job_search_criterion }

  describe 'Serializations' do
    specify '#order_on and #search_on should be hashes' do
      jsc.order_on.class.should == Hash
      jsc.search_on.class.should == Hash
    end

    specify '#recent_jobs should be an Array' do
      jsc.recent_jobs.class.should == Array
    end
  end #Serializations

  describe '#temporary' do
    specify 'default should be false' do
      jsc.temporary.should == false
    end
  end

  describe 'Searches' do
    let!(:job){ create :job }
    let(:record_set){ JobSearchCriterion.send(:mega_join) }

    describe 'category_search(*categories)' do
      it 'should find all jobs that have a category' do
        category = create(:category)
        job2 = create(:job)
        job2.category = category
        jsc.categories << category.code

        jobs = jsc.category_search(record_set)
        jobs.count.should == 1
        jobs.first.should == job2

        job3 = create(:job)
        job3.category = category

        jobs = jsc.category_search(record_set)
        jobs.count.should == 2
        jobs.count.should < Job.count
      end

    end

  end #Searches

end


