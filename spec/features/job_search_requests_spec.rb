require 'spec_helper'

describe 'Job Search Requests' do

  before :each do
    100.times{ create :job }
  end

  specify 'Visiting the page for the first time.' do
    visit '/'
    page.should have_css('.jumbotron')
    find('#job_search').visible?.should == false
  end

end