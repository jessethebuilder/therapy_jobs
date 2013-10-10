require 'spec_helper'

describe 'Job Search Requests' do

  before :each do
    100.times{ create :job }
  end

  describe 'beginning job search', :js => true do
    describe 'unknown user' do
      it 'should open job search criterion form and NOT create a new jsc object for unknown user' do
        visit '/jobs'
        page.should have_css('.jumbotron')
        page.should_not have_css('#job_search')

        expect {click_link 'Search Jobs'}.not_to change{ JobSearchCriterion.count }
        page.should_not have_css('.jumbotron')
        page.should have_css('#job_search')

        within('#job_search'){ click_button 'close' }
        page.should_not have_css('#job_search')
        #jsc should not save if no search is performed
        visit '/jobs'
        page.should have_css('.jumbotron')
        page.should_not have_css('#job_search')
      end

      it 'should remember the search if a search is performed' do
        visit '/jobs'
        click_link 'Search Jobs'
        within('#job_search') do
          fill_in "#job_search_criterion_location_search_search_radius", :with => 100
          fill_in "#job_search_criterion_location_search_address_attributes_city", :with => 'a city'
          expect{ click_link 'Search' }.to change{ JobSearchCriterion.count }.by(1)
        end

        visit '/jobs'
        page.should_not have_css('.jumbotron')
      end
    end

  end


end