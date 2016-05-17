FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testlecturer#{n}@mail.ru" }
    password '123456789'
    nickname 'vasia'
    provider 'email'

    after(:create) do |user|
      user.add_role(:user)
      # user.confirm!
    end

    factory :user_with_course do
      after(:create) do |user|
        user.subscription.courses<< FactoryGirl.create(:course_with_image)
        user.courses<< FactoryGirl.create(:course_with_image)
      end
    end

    factory :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end

    factory :admin_with_course do
      after(:create) do |user|
        user.add_role(:admin)
        user.subscription.courses<< FactoryGirl.create(:course_with_image)
        user.courses<< FactoryGirl.create(:course_with_image)
      end
    end

    factory :lecturer do
      after(:create) do |user|
        user.add_role(:lecturer)
      end
    end

    factory :lecturer_with_course do
      after(:create) do |user|
        user.add_role(:lecturer)
        user.subscription.courses<< FactoryGirl.create(:course_with_image)
        user.courses<< FactoryGirl.create(:course_with_image)
      end
    end
  end
end