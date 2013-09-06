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
    let(:standard_job){ create :job_standard }
    let(:job){ create :job }

    describe 'category search' do
      it 'should find all jobs that have a category' do
        jsc.search_on[:category] = [job.category.code]
        jobs = jsc.search
        jobs.count.should == 1
        jobs.first.should == job
        job2 = create(:job)
        job2.set_category(job.category.code)
        jobs = jsc.search
        jobs.count.should == 2
      end

    end

  end #Searches

end


