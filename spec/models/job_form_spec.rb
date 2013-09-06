require 'spec_helper'

describe JobForm do
  let(:jf){ build :job_form }

  describe '#render' do
    let(:mode_line){ "rbg!!-jfx-!!Settings!!-jfx-!!No Experience;;;Up to 1 Year;;;1 to 3 Years;;;3+ Years" }

    describe '#set_mode(line)' do
      it 'should set the mode and section_title' do
        jf.send(:set_mode, mode_line)
        jf.mode.should == 'rbg'
        jf.section_title = 'Settings'
      end

      it 'should set #answers and add new answers to #saved_answers' do
        jf.send(:set_mode, mode_line)
        jf.answers.count.should == 4
        jf.answers[2].should == '1 to 3 Years'
        jf.saved_answers.last.should == jf.answers.join(JobFormSource::SUB_DEL)
      end

      it 'should find saved answers, by index, if only a number is provided' do
        jf.send(:set_mode, mode_line)
        these_answers = jf.answers
        jf.send(:set_mode, "#{JobFormSource::MODES.sample}#{JobFormSource::DEL}Section Title#{JobFormSource::DEL}0")
        #the operative part of the line above is the 0 at the end.
        jf.answers.should == these_answers
      end

    end
  end
end
