#require 'spec_helper'
#
#describe 'Job Search Requests' do
#
#  before :each do
#    100.times{ create :job }
#  end
#
#  describe 'General Functionality', :js => true do
#
#    specify 'First Visit to Page' do
#      visit '/jobs'
#      page.should_not have_css '.search_row'
#      within '.search_toggle_row' do
#        page.should_not have_link 'Search'
#        click_button 'Search Options'
#        page.should_not have_button 'Search Options'
#      end
#      page.should have_css '.search_row'
#      click_link 'Search'
#      page.should_not have_css '.search_row'
#      page.should have_button 'Search Options'
#      page.should_not have_link 'Search'
#    end
#  end
#
#  describe 'Category Search' do
#
#  end
#
#
#end