# N Plus

The goals of this app are to:
* Demonstrate an N + 1 Problem in Ruby on Rails
* Show some tools available to improve query performance

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

The sole controller action, users#index, demonstrates an N + 1 Problem. As a result, it is slow, with a server response time of about 2.8 seconds, and a page load time of about four seconds.

You can see many redundant queries in the server log. Rails has several tools to address this problem, including `preload`, `eager_load`, `includes`, and writing your own SQL queries.

### Preloading

The `preload` method ships with ActiveRecord and is explored in the user controller. Here is what you will see there:

    # Return all users with comments preloaded
    # (Views: 1839.3ms | ActiveRecord: 2112.8ms)
    #
    #@users = User.all.preload(:comments)

    # Return all users with comments and reviews preloaded
    # (Views: 1072.9ms | ActiveRecord: 497.4ms)
    #
    #@users = User.all.preload(:comments, :reviews)

Preloading reduced server response time from 2752.4ms to 497.4ms.

### Eager Loading

The `eager_load` method also ships with ActiveRecord, and is explored in the user controller. Here's that result:

    # Return all users with comments eager loaded
    # (Views: 1650.1ms | ActiveRecord: 2101.0ms)
    #
    #@users = User.all.eager_load(:comments)

    # Return all users with comments and reviews eager loaded
    # (Views: 1747.7ms | ActiveRecord: 773.6ms)
    #
    #@users = User.all.eager_load(:comments, :reviews)

Eager Loading reduced server response time from 2752.4ms to 773.6ms. Faster, but not as fast as preloading.

### Includes

Next we have `includes`, which chooses between `preload` and `eager_load` based in the situation. Here's how that turned out:

    # Return all users with comments and reviews included
    # (Views: 1018.1ms | ActiveRecord: 486.4ms)
    #
    #@users = User.all.includes(:comments, :reviews)

It chose to `preload`, because there was no additional scope in the action that would necessitate an `eager_load`. About the same response time as `preload`.

Includes is probably the best bet in most situations.

### Custom Select

Finally, we have custom queries. Check out the user model for an example of this method in action.

    # Return all users with a custom query for comments
    # (Views: 1156.3ms | ActiveRecord: 1145.6ms)
    #
    #@users = User.with_comments_count
