Auto Screenshot
===============

A small library designed to help the document web products.

## Usage

    gem install auto_screenshot

### Basics

Pass in an array of URL's,

    urls = ["http://domain.lvh.me:3000", "http://domain.lvh.me:3000/link/1"]
    s = Screenshot.new(:urls => urls)

read from a [.json](/links.json) file,

    s = Screenshot.new(:file => "test.json")  # an array of URL's as string    

or, read a [.rb](/links.rb) file.

    s = Screenshot.new(:file => "/users/name/path/to/links.rb") 

Run Capybara (Selenium) and Firefox. 

    s.go # screenshots are saved to the /screenshots directory as .png files.

### Logging in and custom stuff

[Action Map](/action_map.rb) - an action map allows you to specify certain URL's that call some ruby code that you write.  I built this to accomodate logins. It can be used for whatever.

    s = Screenshot.new({ :file       => "/some/links/in/ruby.rb",
                         :action_map => "/users/name/path/to/action_map.rb" })

load 'lib/auto_screenshot.rb'

    s = AutoScreenshot::Screenshot.new({
      :links => "/users/ryanw/Desktop/ci.rb",
      :action_mappings => "/path/to/action_mappings.json",
      :action_map => "/path/to/action_map.rb",
      :folder => "/path/to/screenshot_images"
    })


#### Remember

* Ensure your website is running when testing locally.
* Don't abuse anybody's website.
