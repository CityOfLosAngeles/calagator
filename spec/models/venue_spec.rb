require File.dirname(__FILE__) + '/../spec_helper'

describe Venue do
  before(:all) do
    @hcal_upcoming = read_sample('hcal_upcoming.xml')
  end

  before(:each) do
    @venue = Venue.new
  end

  it "should extract an AbstractEvent from an hCalendar text" do
    SourceParser::Hcal.stub!(:read_url).and_return(@hcal_upcoming)
    abstract_events = SourceParser::Hcal.to_abstract_events(:url => "http://foo.bar/")
    abstract_event = abstract_events.first
    abstract_location = abstract_event.location

    abstract_location.should be_a_kind_of(SourceParser::AbstractLocation)
    abstract_location.locality.should =~ /portland/i
    abstract_location.street_address.should =~ /317 SW Alder St Ste 500/i
    abstract_location.latitude.should_not be_nil
    abstract_location.longitude.should_not be_nil
  end
end
