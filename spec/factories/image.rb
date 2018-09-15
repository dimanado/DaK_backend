FactoryGirl.define do
  factory :image do
    file File.open(File.join(Rails.root, 'spec', 'support', 'files', 'apple.png'))
  end
end
