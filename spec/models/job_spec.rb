require 'spec_helper'

describe Job do

  let(:job){ create :job }
  let(:job2){ create :job }

  describe 'Validations' do
    it{ should validate_presence_of :duration }
    it{ should validate_numericality_of :duration }
    it{ should have_many :facilities }
    it{ should have_one :category }

    describe 'Complex Validations' do
        it 'must have at least one facility' do
        job.facilities.delete_all
        job.valid?.should == false
        job.errors[:facilities].should_not be_nil
        job.errors.messages[:facilities].match_at(/must have at least one location/).should_not be_nil
      end

      it 'should validate for presence of category' do
        job.category = nil
        job.valid?.should == false
        job.errors[:category].should_not be_nil
        job.errors.messages[:category].match_at(/can't be blank/).should_not be_nil
      end

    end
  end #Associations and Validations

  describe 'Serilizations' do
    specify '#benefits, #requirements and #desirements are arrays' do
      job.benefits = [1]
      job.requirements = [1]
      job.desirements = [1]
      job.benefits.class.should == Array
      job.requirements.class.should == Array
      job.desirements.class.should == Array
    end
  end

  describe '#highlight' do
    it 'should return #highlight if not nil' do
      job.highlight = 'from job'
      job.highlight.should == 'from job'
    end

    it 'should return facilities[0]#description if #highlight is nil' do
      job.facilities[0].description = 'from facility'
      job.highlight.should == 'from facility'
    end
  end

  describe '#client_id' do
    it 'should save client_id of the contact that owns facilities[0]' do
      job.save
      job.client_id.should == job.contact.client_id
    end

    specify '#client_id= should throw a not implemented error' do
      expect{ job.client_id = 0 }.to raise_error(NotImplementedError)
    end
  end

  describe 'Joins and Scopes' do

    describe '#category_join' do
      it 'should return an outer join of categories + jobs' do
        job.save
        join_table = Job.category_join
        join_table.count.should == 1
        join_record = join_table.first
        join_record.category.code.should == job.category.code
        join_record.duration.should == job.duration
      end
    end

    describe '#with_these_categories(*categories)' do
      let(:category2){ create :category }
      before(:each) do
        job2.category = category2
        job2.save
      end

      it 'returns all jobs with a given category' do
        #job2.category = category2
        jobs = Job.with_these_categories(category2.code)
        jobs.count.should == 1
        jobs.first.should == job2
      end

      let(:job3){ create :job }
      let(:category3){ create :category }
      before(:each) do
        job3.category = category3
        job3.save
      end

      it 'accepts arrays of category codes' do
        jobs = Job.with_these_categories([category3.code, category2.code])
        jobs.count.should == 2
        jobs.all.each{ |j| [category2.name, category3.name].include?(j.category.name).should be_true }
      end

      it 'accepts a list of parameters' do
        jobs = Job.with_these_categories(category3.code, category2.code)
        jobs.count.should == 2
        jobs.all.each{ |j| [category2.name, category3.name].include?(j.category.name).should be_true }
      end

    end #with_theses_categories

    describe  '#of_this_client' do

      it 'should return all jobs for a particular client' do
        job.save; job2.save
        jobs = Job.of_this_client(job.contact.client)
        jobs.count.should == 1
        jobs.find(1).should == job
      end
    end


  end #Joins and Scopes

end #describe Job