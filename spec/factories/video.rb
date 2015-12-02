FactoryGirl.define do
  factory :video do
    name 'XVS'
    format 'mp4'
    description 'New video.'
    video File.open(File.join(Rails.root, 'spec', 'support', 'files', 'vd.mp4'))
  end
end