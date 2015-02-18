# N Plus

This is a simple educational app to explain and diagnose the N + 1 problem.

### Initial State

By its very nature, this is not an example of exemplary code.

The average ActiveRecord response time for users/index is 2229.6ms. It takes the page about four seconds in total to load.

### Setup

```
git clone https://github.com/jwworth/n-plus
cd n-plus
rake db:migrate db:populate
```

### Eager Loading

The `preload`, `eager_load`, and `includes` methods are explored in the users controller. You can see example syntax and typical response times for each.

