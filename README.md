# N Plus

The goals of this project are to demonstrate the N + 1 problem in a Ruby on Rails app, and explore common solutions.

### Setup

You can follow along, or use this app to test your own N + 1 solutions.

```
git clone https://github.com/jwworth/n-plus
cd n-plus
bundle install
rake db:migrate db:populate
rails s
```

### Initial State

N Plus has an N + 1 problem.

There is one controller action, 'users#index', which loads every record in the database. The average server response time is about 2.8 seconds, and the average page load time is about 5.5 seconds, without any styling at all. It is just too slow.

The N + 1 problem is visible in the server logs, where you will find many redundant queries:

    (0.7ms)  SELECT COUNT(*) FROM "comments" WHERE "comments"."user_id" = ?  [["user_id", 999]]
    Comment Exists (0.4ms)  SELECT  1 AS one FROM "comments" WHERE "comments"."user_id" = ? LIMIT 1  [["user_id", 999]]
    Review Exists (1.4ms)  SELECT  1 AS one FROM "reviews" WHERE "reviews"."user_id" = ? LIMIT 1  [["user_id", 999]]
    (0.6ms)  SELECT COUNT(*) FROM "comments" WHERE "comments"."user_id" = ?  [["user_id", 1000]]
    Comment Exists (0.5ms)  SELECT  1 AS one FROM "comments" WHERE "comments"."user_id" = ? LIMIT 1  [["user_id", 1000]]
    Review Exists (1.5ms)  SELECT  1 AS one FROM "reviews" WHERE "reviews"."user_id" = ? LIMIT 1  [["user_id", 1000]]

Rails has tools to address this problem. We will look at three of them: `preload`, `eager_load`, and `includes`.

### Preloading

The `preload` method ships with ActiveRecord and is explored in the user controller. Here is what you will see there:

    # Return all users with comments preloaded
    # (Views: 1839.3ms | ActiveRecord: 2112.8ms)
    #
    # @users = User.all.preload(:comments)

    # Return all users with comments and reviews preloaded
    # (Views: 1072.9ms | ActiveRecord: 497.4ms)
    #
    # @users = User.all.preload(:comments, :reviews)

Preloading reduced server response time from 2890.0ms to 497.4ms.

### Eager Loading

The `eager_load` method also ships with ActiveRecord, and is explored in the user controller. Here's that result:

    # Return all users with comments eager loaded
    # (Views: 1650.1ms | ActiveRecord: 2101.0ms)
    #
    # @users = User.all.eager_load(:comments)

    # Return all users with comments and reviews eager loaded
    # (Views: 1747.7ms | ActiveRecord: 773.6ms)
    #
    # @users = User.all.eager_load(:comments, :reviews)

Eager loading reduced server response time from 2890.0ms to 773.6ms. That's faster, but not as fast as preloading.

### Includes

Next we have `includes`, which chooses between `preload` and `eager_load` based on the complexity of the query. Here's that:

    # Return all users with comments and reviews included
    # (Views: 1018.1ms | ActiveRecord: 486.4ms)
    #
    # @users = User.all.includes(:comments, :reviews)

Rails chose to `preload`. If we had additional scope in the action, we might have seen `eager_load` instead. Forcing Rails to make this decision was trivially slower (~10ms) than calling `preload`.

### Conclusion

The `includes` method reduced server response time to 486.4ms, about six times faster. It lets Rails chose between `preload` and `eager_load`, and is the right tool for 90% of situations.

Slow queries should be remedied step-by-step using the server log as a guide. Seek out and eliminate redundant queries whenever you can, using `preload`, `eager_load`, `includes`, and your own SQL ingenuity. The result will be a faster application, longer-lasting hardware, and a better user experience.
