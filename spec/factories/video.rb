FactoryGirl.define do
  factory :video do
    name 'XVS'
    format 'mp4'
    description 'New video.'
    video File.open(File.join(Rails.root, 'spec', 'support', 'files', 'vd.mp4'))

    factory :video_with_image do
      after(:create) do |video|
        video.image = FactoryGirl.build(:image)
        video.save
      end
    end
  end
end