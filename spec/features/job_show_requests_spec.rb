require 'spec_helper'

describe 'Show Jobs' do
  let!(:job){ create :job }
  before(:each) do
    job.main_facility.address.zip = '98362'
    job.main_facility.address.geocode
    job.save
  end

  describe 'Map' do

    describe 'Route From Search', :js => true do
      it 'should raise an error message if #address_string is empty' do
        visit "/jobs/#{job.id}"
        within('#address_map') do
          click_link 'Get Directions'
          page.has_css?('#map_to_address_string.has_error').should be_true
          page.should have_content('Please enter a location ^^^')
        end
      end

      it 'should raise an error is #address_string is not geocodable' do
        visit "/jobs/#{job.id}"
        within('#address_map') do
          fill_in '#address_string', :with => 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
          click_link 'Get Directions'
          page.has_css?('#map_to_address_string.has_error').should be_true
          page.should have_content('Could not locate')
        end
      end

      it 'should not raise an error if the address makes sense' do
        visit "/jobs/#{job.id}"
        #save_and_open_page
        within('#address_map') do
          fill_in '#address_string', :with => '98362'
          click_link 'Get Directions'
          page.has_css?('#map_to_address_string.has_error').should be_false

        end
      end
    end
  end
end