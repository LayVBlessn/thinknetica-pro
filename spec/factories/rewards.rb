FactoryBot.define do
  factory :reward do
    question

    name { "MyReward" }
    file { Rack::Test::UploadedFile.new("/home/layv/Pictures/Screenshot from 2022-01-16 02-57-43.png") }
  end
end
