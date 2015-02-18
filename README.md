# N Plus

This is a simple educational app to demonstrate the N + 1 problem, and a variety of Ruby on Rails solutions.

### Setup

```
git clone https://github.com/jwworth/n-plus
cd n-plus
bundle install
rake db:migrate db:populate
rails s
```

### Initial State

By its very nature, this is not an example of exemplary code.

The average ActiveRecord response time for users/index is 2229.6ms. It takes the page about four seconds to load in a browser. You can see many redundant queries in the server log.

### Eager Loading

The `preload`, `eager_load`, and `includes` methods are explored in the users controller. There you will find example syntax and typical response times for each.

The fastest method was `includes`, which reduced server response time from ~2273ms to ~25.7ms, a dramatic improvement. The view response time improved from ~1496ms to ~870ms.
