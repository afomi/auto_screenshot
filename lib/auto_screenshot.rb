require "auto_screenshot/version"

require 'uri'
require 'json'
require 'capybara/dsl'

module AutoScreenshot

  class Screenshot

    include Capybara::DSL
    Capybara.default_driver = :selenium

    attr_accessor :urls, :folder, :action_map_path, :action_map

    def initialize(opts = { :urls => [], :file => "", :rb_file => nil, :action_map_path => "", :folder => "" })
      raise Exception, "please pass in an array of urls like {:urls => []}, or a file, like {:file => \"test.json\"}" unless opts[:urls] or opts[:file] or opts[:rb_file]

      if opts[:urls]
        @urls = opts[:urls]
      elsif opts[:rb_file]
        require_relative opts[:rb_file]
        @urls = $links
      elsif opts[:file]
        @urls = JSON.parse(File.open(opts[:file], "r").read)
      end

      @action_map_path = opts[:action_map_path]
      @folder = opts[:folder] ||= "screenshots"
      @action_map = action_map
    end

    def go
      errors = []
      @urls.each do |url|
        begin
          puts "Getting #{url}"
          visit "#{url}"

          page.wait_until do
            page.evaluate_script 'jQuery.active == 0'
          end
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

    def action_map
      json = File.open(@action_map_path).read
      hash = JSON.parse(json)
    end


    # custom actions for Granicus
    # something custom based on a page.  pages must be ordered in the URL array though
    def actions(url)
      # do a specific action for a url, like login

      if action_map.has_key?(url)
        self.send(action_map[url])
      else
        nil
      end
    end

    def login
      click_on "Sign in / up"
      sleep 2.0
      fill_in "user_email", :with => "ryanw@granicus.com"
      fill_in "user_password", :with => ""
      click_on "Sign in"
      sleep 2.0
      wait_for_ajax
    end

    def wait
      sleep 15.0
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
      Capybara.current_session.driver.browser.save_screenshot("#{File.dirname(__FILE__)}/#{@folder}/#{name}.png")
    end

  end

end
