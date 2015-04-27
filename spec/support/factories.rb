FactoryGirl.define do 
  factory :user do 
    sequence(:name) { |n| "Name Number #{n}" }
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"

    factory :admin, parent: :user do 
      email "bennettatoms@hotmail.com"
      admin true
    end
  end

  factory :tweet_sentiment do 
    search_term { Faker::Lorem.words }
    sentiment_score { Faker::Number.number(1) }
    user
  end
end

