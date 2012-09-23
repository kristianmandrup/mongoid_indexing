# Mongoid Indexing

Programmatic index creation and removal for Mongoid.

## Install

`gem 'mongoid_indexing'`

Then bundle it!

## Usage

Programmatic access to index creation and removal is useful in project where you don't have access to rake tasks such as those for `mongoid:db`. This is fx the case when using Rails engines.

Scenario: Using Mongoid Geospatial to create geo positions for properties. For geo searches to work, you need to create 2d indexes!

```ruby
# RANDOM PROPERTIES
describe Property do
  before :all do
    Mongoid::Indexing.create_indexes
  end

  after :all do
    Mongoid::Indexing.remove_indexes
  end

  before :each do
    10.times do
      Property.create type: 'apartment', position: random_point_within(10.kms)
    end      
  end
end
```

Enjoy ;)

## Contributing to mongoid_indexing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kristian Mandrup. See LICENSE.txt for
further details.

