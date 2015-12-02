FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "c##{n}" }
    heading 'best language'
    description 'Best of the best'

    factory :course_with_image do
      after(:create) do |course|
        course.image = FactoryGirl.build(:image)
        course.save
      end
    end
  end

end