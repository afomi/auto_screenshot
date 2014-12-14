require "auto_screenshot/version"
require 'capybara/dsl'
require 'json'
require 'uri'

module AutoScreenshot

  class Screenshot
    attr_accessor :urls, :folder, :action_map

    include Capybara::DSL
    Capybara.default_driver = :selenium

    # urls: an array of full URL strings
    # folder: where to store the files
    # action_map: a hash where
    #               keys are URL's that are visited
    #               values are symbols for custom actions
    #
    # see the `wait` method for an example of mapping an action
    def initialize(options = {
                    urls: [],
                    folder: nil,
                    action_map: {}
                  })
      @urls = options[:urls]
      @folder = options[:folder] ||= "screenshots"
      @action_map = options[:action_map]
    end

    # Passing `dry_run=true`
    # only lists the URL's that would be processed
    # but does not take screenshots
    def go(dry_run = false)
      raise 'no URLs specified' if @urls.empty?

      errors = []

      @urls.each do |url|
        p url; next if dry_run

        begin
          puts "Getting #{url}"
          visit "#{url}"
          sleep 3.0 # arbitrary sleep to allow heavily ajax-y pages to load
          snap
          actions(url)
        rescue => err
          puts err.inspect
          puts "error on #{url}"
          errors << url
        end
      end

      errors
    end

    # Custom actions, based on a page url
    # do a specific action for a url, like #wait
    def actions(url)
      if action_map && action_map.has_key?(url)
        self.send(action_map[url])
      else
        nil
      end
    end

    # Define custom actions by monkey-patching.
    # Use the custom actions
    # by passing action_map: { :url => :method }
    #
    # class AutoScreenshot::Screenshot
    #   def your_custom_action
    #   end
    # end
    def wait
      sleep 10.0
    end

    # TODO: Helper Method
    def grab_links(url)
      links = []

      visit "#{url}"
      nodes = Nokogiri::HTML(page.html).css("a")
      nodes.each do |link|
        links << link["href"]
      end
      links.uniq
    end

    # passing a `descriptor`
    # adds a string to the filename, so you can name a sub-state for a page
    def snap(descriptor = "")
      name = clean_url(page.current_url)

      # Descriptor
      name = name + (descriptor.empty? ? "" : "-state-#{descriptor}")
      p "#snap", "name", name unless name.empty?

      set_window_size

      # Ensure @folder exists
      FileUtils.mkdir_p(@folder) unless File.exists?(@folder)
  Capybara.current_session.driver.browser.save_screenshot("#{@folder}/#{name}.png")
    end


    private

    def clean_url(full_url)
      p "#clean_url", full_url

      full_url.gsub("https:\/\/", "")
              .gsub("http:\/\/", "")
              .gsub(":", "")
              .gsub("\/", "-")
              .gsub("&", "-")
              .gsub("?", "_")
    end

    def set_window_size
      Capybara.current_session.driver.browser.manage.window.resize_to(1200, 800)
    end

  end
end
