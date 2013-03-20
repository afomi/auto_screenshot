require "auto_screenshot/version"

require 'uri'
require 'json'
require 'capybara/dsl'

module AutoScreenshot

  class Screenshot
    include Capybara::DSL
    Capybara.default_driver = :selenium

    attr_accessor :links, :folder, :action_mappings, :action_map

    # Pass in an array of URL's, with http(s)
    #   or
    # Pass in a .json or .rb file of links
    #
    # pass in an action_map
    # pass in a folder path to where to store the screenshots
    def initialize(opts = { :links => "", :action_mappings => [], :action_map => "", :folder => "" })
      raise Exception, "please pass in an array of urls like {:urls => []}, or a file, like {:file => \"test.json\"}" unless opts[:links]

      @links = opts[:links]
      if @links.class == Array
        @links = links
      elsif links.class == String
        ext = File.extname(@links)
        if ext == ".rb"
          load @links
          @links = $links
        elsif ext == ".json"
          @links = JSON.parse(File.open(@links, "r").read)
        end
      end

      @action_mappings = set_action_mappings(opts[:action_mappings])
      load opts[:action_map].to_s
      @folder = opts[:folder] ||= "screenshots"
    end

    def go
      errors = []
      @links.each do |url|
        begin
          puts "Getting #{url}"
          visit "#{url}"

          snap
          actions(url)
        rescue => err
          puts err.inspect
          puts "error on #{url}"
          errors << url
        end
      end

      puts errors
    end

    # Load an action map .json file
    # see /action_mappings.json as an example
    # {
    #   "url":<method in action_map.rb>
    # }
    def set_action_mappings(path)
      return {} if path && path.empty?

      json = File.open(path).read
      hash = JSON.parse(json)
    end

    # do a specific action for a url, like login
    def actions(url)
      if action_mappings.has_key?(url)
        sleep 10.0
        # self.send(action_mappings[url])
      else
        nil
      end
    end

    def grab_links(url)
      links = []

      visit "#{url}"
      nodes = Nokogiri::HTML(page.html).css("a")
      nodes.each do |link|
        links << link["href"]
      end
      links.uniq
    end

    def snap
      page.execute_script('$(window).width(1200)')
      name = page.current_url.gsub("https:\/\/", "").gsub("http:\/\/", "").gsub(":", "").gsub("\/", "-").gsub("&", "-").gsub("?", "_").gsub("dev.lvh.me3000-", "").gsub("admin.lvh.me3000-", "").gsub("localhost3001-", "").gsub("dev.dev.lvh.me3000-", "").gsub("test.civicideasstaging.com", "")
      Capybara.current_session.driver.browser.manage.window.resize_to(1000, 800)
      Capybara.current_session.driver.browser.save_screenshot("#{@folder}/#{name}.png")
    end

  end

end
