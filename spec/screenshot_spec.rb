require 'spec_helper'
include AutoScreenshot

describe Screenshot do

  describe ".new()" do
    it "should raise Error when not passed any arguments" do
      lambda {
        Screenshot.new
      }.should raise_error(ArgumentError)
    end
  end

  describe ".new(:links => [])" do
    before do
      @auto_screenshot = Screenshot.new(:links => ["http://www.afomi.com", "http://granicus.com", "http://github.com/afomi"])
    end

    it "is valid" do
      @auto_screenshot.should be_true
    end

    it "has the expected attributes" do
      @auto_screenshot.methods.include?(:links)
      @auto_screenshot.methods.include?(:action_mappings)
      @auto_screenshot.methods.include?(:action_map)
      @auto_screenshot.methods.include?(:folder)
      @auto_screenshot.methods.include?(:url_to_wait_at)
    end

    describe ".links" do
      it "is an Array" do
        @auto_screenshot.links.length.should eq 3
      end

      it "has 3 URLs" do
        @auto_screenshot.links.length.should eq 3
      end
    end

    describe ".go!" do
      before do
        @auto_screenshot.go!
      end

      it "saves 3 files in /screenshots" do
        pending
      end
    end
  end

  describe ".new(:links => 'links.json')" do
    before do
      @auto_screenshot = Screenshot.new(:links => "/Users/ryanw/Dropbox/Development/gems/auto_screenshot/examples/links.json")
    end

    it "has methods" do
      @auto_screenshot.methods.include?(:links)
      @auto_screenshot.methods.include?(:action_mappings)
      @auto_screenshot.methods.include?(:action_map)
      @auto_screenshot.methods.include?(:folder)
    end

    it "has 7 URLs" do
      @auto_screenshot.links.length.should eq 7
    end

    describe ".links" do
      it "should" do
        @auto_screenshot.links.include?(:links)
      end
    end
  end

  describe ".new(:links => 'links.rb')" do
    before do
      @auto_screenshot = Screenshot.new(:links => "/Users/ryanw/Dropbox/Development/gems/auto_screenshot/examples/links.rb")
    end

    it "has 10 URLs" do
      @auto_screenshot.links.length.should eq 10
    end
  end

  describe "civicideas testing" do
    before do
      @auto_screenshot = AutoScreenshot::Screenshot.new(:links => "/Users/ryanw/Dropbox/Development/gems/auto_screenshot/examples/civicideas_staging.rb")
    end

    it "saves some pages!" do
      @auto_screenshot.go!
    end
  end

end
