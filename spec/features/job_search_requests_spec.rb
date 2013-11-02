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
          select 'Washington', :from => 'States'
          expect{ click_link 'Search' }.to change{ JobSearchCriterion.count }.by(1)
          jsc = JobSearchCriterion.last
          jsc.states.include?('wa').should be_true
        end
      end
    end

  end

  describe 'LocationSearches', :js => true do
    it 'should save the a LocationSearch when a JobSearchCriterion is saved or updated, if one is specified' do
      visit '/jobs'
      click_link 'Search Jobs'
     # within('#location_search') do
        fill_in 'Address', :with => 'Sequim, WA'
        #fill_in 'Search radius', :with => 200
      #end
      click_link 'Search'

      lc = LocationSearch.last
      lc.address.address_string.should == 'Sequim, WA'
      lc.search_radius.should == 200

      jsc = JobSearchCriterion.last
      lc.job_search_criterion.should == jsc

      click_link 'Search Jobs'
      within('#location_search') do
        fill_in 'Address', :with => 'Port Angeles, WA'
        #fill_in 'Search radius', :with => 155
      end
      expect{ click_link 'Search' }.to change{ jsc.location_searches.count }.by(1)

      lc = LocationSearch.last
      lc.address.address_string.should == 'Port Angeles, WA'
      lc.search_radius.should == 155
    end
  end


end