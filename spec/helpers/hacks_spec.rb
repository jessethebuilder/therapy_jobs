require 'spec_helper'

describe Hacks do
  describe '#articleator' do
    it 'should return word parameter and proper article' do
      articleator('dog').should == 'a dog'
      articleator('ostrich').should == 'an ostrich'
    end

    it 'should maintain capitalization of word' do
      articleator('eagle').should == 'an eagle'
      articleator('Crow').should == 'a Crow'
    end

    it 'should capitalize article property if capitalize is set to true (default is false)' do
      articleator('apple').should == 'an apple'
      articleator('jack', true).should == 'A jack'
    end
  end #articleator

  describe '#add_commas_and_ands' do
    it 'should return the original value if only one item is given' do
      add_commas_and_ands(['cat']).should == 'cat'
    end

    it 'should return two items seperated by an and /w no comma' do
      add_commas_and_ands(%w|cats dogs|).should == 'cats and dogs'
    end

    it 'should return three or more items, seperated by commas, and an and before the last item' do
      add_commas_and_ands(%w|cats dogs hamsters fish|).should == 'cats, dogs, hamsters, and fish'
    end

    it 'should work with an alternate separator (as opposed to a comma) if parameter is supplied' do
      add_commas_and_ands(%w|mice rats raccoons|, ';').should == 'mice; rats; and raccoons'
    end
  end #add_commas_and_ands

  describe '#float_to_years_and_months(float)' do
    it 'should return the number of years if float is an integer or parses to an integer' do
      float_to_years_and_months(1).should == '1 year'
      float_to_years_and_months(1.0).should == '1 year'
    end

    it 'should return months and years if the decimal value is not .0' do
      float_to_years_and_months(1.5).should == '1 year and 6 months'
      float_to_years_and_months(2.25).should == '2 years and 3 months'
      float_to_years_and_months(3.3).should == '3 years and 4 months'
      float_to_years_and_months(9.66).should == '9 years and 8 months'
    end

    it 'should handle plurals properly' do
      float_to_years_and_months(1.1).should == '1 year and 1 month'
      float_to_years_and_months(10.75).should == '10 years and 9 months'
    end

  end #float_to_years_and_months

  describe 'Array monkey patch' do

    describe '#match_at' do
      a = %w|abc 123 xyz|
      specify 'it should return the index position of the FIRST item that matches regex' do
        a.match_at(/b/).should == 0
      end

      specify 'it should work with strings as well' do
        a.match_at('2').should == 1
      end

      specify 'should return nil if no match is found' do
        a.match_at('h').should == nil
      end
    end

  end #Array mp
end