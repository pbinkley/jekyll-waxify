# Jekyll::Waxify
A gem-packaged Jekyll plugin that installs basic minicomp/wax components 

This gem installs the simplest possible framework for [Wax](https://minicomp.github.io/wax) IIIF support in a Jekyll site. It is intended to be used in teaching, as well as to flatten the learning curve for those who are new to Wax.

This is a work in progress. If you try it on an existing Jekyll site, be sure you have a recent backup.

TODOs:

- [x] deploy to RubyGems
- [x] provide scaffolding for Wax iiif images
- [ ] enable import of images on collection creation
- [x] refactoring
- [ ] provide scaffolding for Wax indexing
- [ ] test with mature Jekyll sites
- [x] add specs
- [ ] explain multi-image items

A minimal demo site can be seen at [https://pbinkley.github.io/jekyll-waxify](https://pbinkley.github.io/jekyll-waxify). 

## Installation

In order to make the site compatible with Github Pages, use the github pages gem to manage the Jekyll version. In your Jekyll site's Gemfile, comment out the Jekyll line:

```ruby
# gem "jekyll", "~> 4.2.0"
```

And add these lines to the ```jekyll_plugins``` group:

```ruby
gem 'github-pages', '~> 214'
gem 'jekyll-waxify', '~> 0.1'
```

And add this section:

```ruby
group :development do
  gem 'wax_tasks', '~> 1.1'
end
```

And then execute:

    $ bundle update

## Usage

You can then waxify your Jekyll site and create a Wax image collection:

    $ bundle exec jekyll waxify <collection name>

This creates all the scaffolding for your collection. To populate it, copy images into ```_data/raw_images/<collection name>/```, and edit the csv file ```_data/<collection name>.csv```: for each image add a row containing the file name (without extension) and a label. E.g. for a map image ```1234.tif``` the row should contain ```1234,Map of Paris```. 

Now you can generate the Wax artefacts for your collection:

    $ bundle exec rake wax:derivatives:iiif <collection name>
    $ bundle exec rake wax:pages <collection name>

And view the site in the normal Jekyll way:

    $ bundle exec jekyll serve

The "Collections" link in the tab bar will take you to your new collection.

## What the Scaffolding Provides

The scaffolding adds a [number of files](https://github.com/pbinkley/jekyll-waxify/tree/main/wax-framework) to your Jekyll site. These are copied from the Wax demo site. They include the Rakefile needed to run the Wax tasks, the various assets needed to provide Jekyll services (including OpenSeadragon etc.), a collections.markdown page to provide access to the IIIF collections, and the Jekyll includes and layouts needed to generate item-level pages. 

The scaffolding assumes only two metadata fields: the required ```pid``` and a ```label```. You can add more fields by adding columns to your collection csv. The fields will be displayed by default on the item-level page under the image, and are available for use in the normal Jekyll way.

The ```_includes``` files you will most likely want to modify are:

- [osd\_iiif\_image\_viewer.html](https://github.com/pbinkley/jekyll-waxify/blob/main/wax-framework/_includes/osd_iiif_image_viewer.html): This provides the template for an OpenSeadragon display of a IIIF item. If you want to change the configuration of the OpenSeadragon display, this is where you do it.
- [collection\_gallery.html]https://github.com/pbinkley/jekyll-waxify/blob/main/wax-framework/_includes/collection_gallery.html): This provides the ```div``` containing an item on the collections page.

You might also want to tinker with these:

- [item\_metadata.html](https://github.com/pbinkley/jekyll-waxify/blob/main/wax-framework/_includes/item_metadata.html): Controls the display of metadata in a table under the OpenSeadragon image.
- [item\_pagination.html](https://github.com/pbinkley/jekyll-waxify/blob/main/wax-framework/_includes/item_metadata.html): Controls the pagination links to previous and next images in multi-image items.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pbinkley/jekyll-waxify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pbinkley/jekyll-waxify/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll::Waxify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pbinkley/jekyll-waxify/blob/master/CODE_OF_CONDUCT.md).
