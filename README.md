# N Plus

This is a simple educational app to help explain and diagnose the N + 1 problem.

### Initial State

By its very nature, this is not an example of exemplary code.

The average ActiveRecord response time for users/index view is 2229.6ms. It takes the page about four seconds to load.

### Setup

```
git clone https://github.com/jwworth/n-plus
cd n-plus
rake db:migrate db:populate
```

### Eager Loading

The `preload`, `eager_load`, and `includes` methods are explored in the users controller.

