FactoryGirl.define do
  factory :user do

  end
   factory :user do
       username "TestUser"
       password "SuperSecret"
     end

   factory :pose do
     sequence :name do |n|
       "pose #{n}"
     end

     sequence :description do |d|
       "desc #{d}"
     end
   end

   factory :sequence do
     sequence :title do |t|
       "title #{t}"
     end

     sequence :difficulty do |d|
       "diff #{d}"
     end

     sequence :repititions do |r|
       "reps #{r}"
     end
   end

   factory :comment do
     content "this is a test comment"
     association :sequence
     association :user
   end
end
