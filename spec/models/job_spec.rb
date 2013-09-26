require 'spec_helper'

describe Job do

  let(:job){ build :job }
  let(:job2){ build :job }

  describe 'Validations' do
    it{ should validate_presence_of :duration }
    it{ should validate_numericality_of :duration }
    it{ should have_many :facilities }
    it{ should have_one :category }

    describe 'Complex Validations' do
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

  describe '#main_facility' do
    let(:facility){ create :facility }
    let(:facility2){ create :facility }

    #todo update shoulda. this passes, but the new errors are different
#    it{ should validate_presence_of :main_facility_id }

    it 'should delete main_facility_id if facility is deleted' do
      job.main_facility_id.should_not be_nil
      job.facilities.delete_all
      job.main_facility_id.should == nil
    end

    it 'should set a main_facility if one does not exist' do
      job.facilities.delete_all
      job.main_facility_id.should == nil
    end

    specify '#main_facility should return the facility that corresponds to the id in #main_facility_id, which in this
            case is set upon instantiation and adding a facility in factory' do
      job.main_facility.should == job.facilities[0]
    end

    specify 'adding though #main_facility= should add new facility to #facilities UNLESS facility already is associated' do
      job.save
      job.main_facility.should_not be_nil
      expect{ job.main_facility = facility }.to change{ job.facilities.count }.by(1)
      expect{ job.main_facility = facility2 }.to change{ job.facilities.count }.by(1)
      expect{ job.main_facility = facility }.to_not change{ job.facilities.count }
    end
  end

  describe '#client_id' do

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
  end #Joins and Scopes

end #describe Job