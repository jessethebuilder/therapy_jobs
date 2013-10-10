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
end