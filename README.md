# CaptionPaperclipProcessor

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'caption_paperclip_processor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caption_paperclip_processor

## Usage

```ruby
class ImageWithCaption  < ActiveRecord::Base
  has_attached_file :image, styles: {
    geometry: "350x250",
    processors: [:caption],
    caption: "Some caption text",
    position: 'center',
    interword_spacing: 10,
    kerning: 2.5,
    padding_height: 12,
    padding_width: 26,
    font: Rails.root.join('app', 'assets', 'fonts', 'someFont.ttf'),
    font_color: "rgba\\(255,255,255,0.8\\)",
    caption_background: "gray"
  }
end
```

The geometry will be the size of the caption that will fill the caption. Font
size will be whatever is 'best fit' into the caption 'box'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

