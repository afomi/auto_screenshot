# AutoScreenshot

Built to capture screenshots of a list of webpages in an automated fashion.

## Installation

Add this line to your application's Gemfile:

    gem 'auto_screenshot'

And then run:

    bundle

Or install it yourself as:

    gem install auto_screenshot

## Options

### URLs

An array of valid URLs. Pretty simple.

### Folder

`folder` is where the screenshots will be saved.  The default location is the `screenshots` folder based on where the program is run. But, the example below passes a specific folder path to save screenshots at.

    client = AutoScreenshot::Screenshot.new(:folder => '/path/to/folder/')

### Action Map

`action_map` is a ruby hash. each key of the hash is a full URL string
and each key is a symbol. The symbol corresponds to a name of a method like `wait`. Here is an example:

    action_map = {
      "http://example.com/page" => :wait
    }

And a custom method could look like:

    def wait
      sleep 10 # To allow you to login or something
    end

## Usage

AutoScreenshot saves screenshots of webpages as .png files in a folder.  Create a Screenshot client and specify an array of URLs to capture.

#### Create a Client. Then set options.

    client = AutoScreenshot::Screenshot.new #=> get a Screenshot object
    client.urls = ["http://google.com, http://github.com"]
    client.folder = "/custom/folder/path"
    client.action_map = {
      "http://example.com/do-something-custom-at-this-url" => :custom_method
    }


or

#### Create a Client with options.

    client = AutoScreenshot::Screenshot.new(:urls => [], :folder => "/custom/folder/path", :action_map => {@url_string => :custom_method})

## Contributing

1. Say [hi](https://twitter.com/randw) and let me know you're using aut
1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request

### During Development

Run this from the `auto_screenshot/` directory.

    irb
    load 'lib/auto_screenshot.rb'

And, to build the .gem:

    gem build auto_screenshot.gemspec
