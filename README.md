middleman-react [![Gem Version](https://badge.fury.io/rb/middleman-react.svg)](http://badge.fury.io/rb/middleman-react) [![Build Status](https://travis-ci.org/plasticine/middleman-react.png?branch=master)](https://travis-ci.org/plasticine/middleman-react) [![Code Climate](https://codeclimate.com/github/plasticine/middleman-react.png)](https://codeclimate.com/github/plasticine/middleman-react)
===============

### Use [React] JSX transformations with [Middleman].

Inspired (and pretty much a clone of really) the [react-rails] gem for Middleman. This gem allows you to write and use `*.jsx` assets inside Middleman.

#### Usage
1. `gem install middleman-react`
2. `activate :react` in `config.rb`

##### Options

It is also possible to pass options through to the JSX compiler if that’s your thing:

``` ruby
activate :react do |config|
  config.harmony = true
  config.strip_types = true
end
```

#### Sprockets loading react-source

In your Middleman `config.rb` add the following:

``` ruby
after_configuration do
  sprockets.append_path File.dirname(::React::Source.bundled_path_for('react.js'))
end
```

Now you can Sprockets include React:

```
//= require react
```

Or with addons:

```
//= require react-with-addons
```

#### A note on versioning

The version for this gem will reflect that of the underlying version of `react-source`, meaning that using `0.12.1` of this gem will give you version `0.12.1` of React. This is the same approach that `react-rails` takes.
If updates to the gem code are required that do not alter the `react-source` version in use need to be made they will be released with a `.x` version appended, eg: `0.12.1.1`.

#### Developing / Contributing
1. Fork it!
2. Get set up: `./script/bootstrap`
3. ...?
4. Run specs: `./script/spec`
5. Pull request!

[React]:       http://facebook.github.io/react/
[Middleman]:   http://middlemanapp.com
[react-rails]: https://github.com/facebook/react-rails
