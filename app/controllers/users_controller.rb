class UsersController < ApplicationController
  def index
    # Return all users
    # Typical result: (Views: 1495.8ms | ActiveRecord: 2273.4ms)
    #
    @users = User.all

    # PRELOADING, EAGER LOADING, AND INCLUDES
    #
    # Return all users with comments preloaded
    # Typical result: (Views: 1186.8ms | ActiveRecord: 1592.0ms)
    #
    # @users = User.all.preload(:comments)

    # Return all users with comments and reviews preloaded
    # Typical result: (Views: 678.8ms | ActiveRecord: 30.0ms)
    #
    # @users = User.all.preload(:comments, :reviews)

    # Return all users with comments eager loaded
    # Typical result: (Views: 1135.6ms | ActiveRecord: 1534.2ms)
    #
    # @users = User.all.eager_load(:comments)

    # Return all users with comments and reviews eager loaded
    # Typical result: (Views: 1409.5ms | ActiveRecord: 611.5ms)
    #
    # @users = User.all.eager_load(:comments, :reviews)

    # Return all users with comments and reviews included
    # Typical result: (Views: 870.2ms | ActiveRecord: 25.7ms)
    #
    # @users = User.all.includes(:comments, :reviews)
  end
end
