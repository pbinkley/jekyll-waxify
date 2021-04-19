# Jekyll::Waxify
A gem-packaged Jekyll plugin that installs basic minicomp/wax components 

This gem installs the simplest possible framework for [Wax](https://minicomp.github.io/wax) IIIF support in a Jekyll site. It is intended to be used in teaching, as well as to flatten the learning curve for those who are new to Wax.

This is a work in progress. If you try it on an existing Jekyll site, be sure you have a recent backup.

TODOs:

- [ ] deploy to RubyGems
- [x] provide scaffolding for Wax iiif images
- [ ] enable import of images on collection creation
- [x] refactoring
- [ ] provide scaffolding for Wax indexing
- [ ] test with mature Jekyll sites
- [x] add specs

A minimal demo site can be seen at [https://pbinkley.github.io/jekyll-waxify](https://pbinkley.github.io/jekyll-waxify). 

## Installation

In order to make the site compatible with Github Pages, use the github pages gem to manage the Jekyll version. In your Jekyll site's Gemfile, comment out the Jekyll line:

```ruby
# gem "jekyll", "~> 4.2.0"
```

And add these lines to the ```jekyll_plugins``` group:

```ruby
gem 'github-pages', '~> 213'
gem 'jekyll-waxify', '0.1.0'
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

    $ bundle exec rake wax:pages <collection name>
    $ bundle exec rake wax:derivatives:iiif <collection name>

And view the site in the normal Jekyll way:

    $ bundle exec jekyll serve
    
The "Collections" link in the tab bar will take you to your new collection.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pbinkley/jekyll-waxify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pbinkley/jekyll-waxify/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll::Waxify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pbinkley/jekyll-waxify/blob/master/CODE_OF_CONDUCT.md).
