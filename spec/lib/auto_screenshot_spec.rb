require 'spec_helper'

describe AutoScreenshot::Screenshot do

  describe "#initialize" do
    context "no args" do
      before do
        @client = AutoScreenshot::Screenshot.new
      end

      it "instantiates" do
        expect(@client.instance_variables).to match_array [:@urls, :@folder, :@action_map]
        expect(@client.urls.size).to eq 0
        expect(@client.action_map).to eq {}
        expect(@client.folder).to eq 'screenshots'
      end
    end

    context "with :urls" do
      before do
        @client = AutoScreenshot::Screenshot.new({
          urls: [
            "http://google.com",
            "http://communicatingdesign.com"
          ]
        })
      end

      describe ".new" do
        it "instantiates" do
          expect(@client.urls.size).to eq 2
          expect(@client.folder).to eq 'screenshots'
          expect(@client.action_map).to eq {}
        end
      end
    end

    context "with :folder" do
      before do
        @client = AutoScreenshot::Screenshot.new({
          folder: 'custom_folder',
          urls: '[http://google.com]'
        })
      end

      it "instantiates" do
        expect(@client.folder).to eq 'custom_folder'
      end
    end

    context "with :action_map" do
      before do
        @client = AutoScreenshot::Screenshot.new({
          action_map: {
            :url => :custom_method
          }
        })
      end

      it "instantiates" do
        expect(@client.action_map).to eq ({
          :url => :custom_method
        })
      end
    end
  end

  describe "#go" do
    before do
      @client = AutoScreenshot::Screenshot.new({
        urls: [
          "http://google.com",
          "http://communicatingdesign.com"
        ]
      })
    end

    describe "#go" do
      before do
        @client.go
      end

      it "save screenshots as .png on Filesystem" do
        expect(Dir.glob("screenshots/communicatingdesign*.png").size).to eq 1
        expect(Dir.glob("screenshots/www.google*.png").size).to eq 1
      end
    end
  end

  describe "#actions" do
  end

  describe "#grab_links" do
  end

  describe "#wait" do
    # `wait` is an example of an action used by the `action_map`
  end

  describe "#snap" do
  end

end
