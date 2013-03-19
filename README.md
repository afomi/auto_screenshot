Auto Screenshot
===============

A small library designed to help document web products.

## Usage

From console, within the /auto_screenshot directory:
    
    irb
    load auto_screenshot.rb

This works in 2 ways:

Method 1: Pass in an array of URL's

    urls = ["http://ryanwold.net", "http://afomi.com", "http://www.granicus.com"]
    s = Screenshot.new(:urls => urls) # => an array of URL's as strings

Or

Method 2: Read from a .json file

    s = Screenshot.new(:file => "test.json")  # => an array of URL's as strings
    s.go # => screenshots are saved to the /screenshots directory as .png files

    gem install auto_screenshot
    rake screenshots --all
    
screenshot based on a .rb file or pass arguments

    load 'auto_screenshot.rb'
    s = Screenshot.new(:file => "test.json")
    s.go

Alternatively, use a ruby file to generate a @links array of URL strings for each page (see dmap.rb as an example)

    load 'dmap.rb'
    s = Screenshot.new(:urls => $links)

#### Remember

* Ensure your website is running when testing locally.
* Don't abuse anybody's website.
