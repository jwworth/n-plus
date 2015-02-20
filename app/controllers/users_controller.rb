class UsersController < ApplicationController
  def index
    # Return all users
    # (Views: 2049.9ms | ActiveRecord: 2890.0ms)
    #
    @users = User.all

    # PRELOADING, EAGER LOADING, AND INCLUDES
    #
    # Return all users with comments preloaded
    # (Views: 1839.3ms | ActiveRecord: 2112.8ms)
    #
    # @users = User.all.preload(:comments)

    # Return all users with comments and reviews preloaded
    # (Views: 1072.9ms | ActiveRecord: 497.4ms)
    #
    # @users = User.all.preload(:comments, :reviews)

    # Return all users with comments eager loaded
    # (Views: 1650.1ms | ActiveRecord: 2101.0ms)
    #
    # @users = User.all.eager_load(:comments)

    # Return all users with comments and reviews eager loaded
    # (Views: 1747.7ms | ActiveRecord: 773.6ms)
    #
    # @users = User.all.eager_load(:comments, :reviews)

    # Return all users with comments and reviews included
    # (Views: 1018.1ms | ActiveRecord: 486.4ms)
    #
    # @users = User.all.includes(:comments, :reviews)
  end
end
