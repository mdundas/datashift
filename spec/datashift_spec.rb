# Copyright:: (c) Autotelik Media Ltd 2011
# Author ::   Tom Statter
# Date ::     Oct 2011
# License::   MIT
#
# Details::   Specs for high level apsects of DataShift library
#
require File.dirname(__FILE__) + '/spec_helper'

describe 'DataShift' do

  before(:each) do
  end
  
  it "should provide gem version" do
    DataShift::gem_version
  end

  it "should provide gem name" do
    DataShift::gem_name.should == 'datashift'
  end
  
  it "should provide root_path" do
    DataShift.root_path.should_not be_empty
  end

  it "should provide a log" do
    class Blah
      include DataShift::Logging
      
      def try_me
        logger.info "hello datashift spec"
      end
    end
    
    
    b = Blah.new()
    
    b.logger.info "try me"
    
    b.try_me
    
    
  end
  
end