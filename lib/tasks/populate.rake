namespace :db do
  task populate: :environment do

    User.destroy_all
    Comment.destroy_all
    Review.destroy_all

    def random_status
      ['new', 'legacy', 'admin'].sample
    end

    def random_user
      rand(1..500)
    end

    1000.times do
      User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number,
        status: random_status,
      )
    end
    5000.times do
      Comment.create(
        body: Faker::HipsterIpsum.words(10).join(' '),
        user_id: random_user
      )
      Review.create(
        body: Faker::HipsterIpsum.words(50).join(' '),
        user_id: random_user
      )
    end
  end
end
