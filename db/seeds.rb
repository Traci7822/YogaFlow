# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sequence_list = [
  ["Good Evening Flow", 0, "relaxation", 1],
  ["Surya Namaskar A", 0, "sun-salutations", 2],
  ["Standing Balance", 0, "balance", 3],
  ["Half Mandala Surrencer", 0, "relaxation", 3],
  ["Energizing Solar Sequence", 0, "circulation", 2]
]

sequence_list.each do |title, number_of_poses, focus, difficulty|
  Sequence.create(title: title, number_of_poses: number_of_poses, focus: focus, difficulty: difficulty)
end

pose_list = [
  ["Urdhva Vrikshasane", "Upward Tree Position"],
  ["Uttanasana", "Standing Forward Fold"],
  ["Ardha Uttanasana", "Half Standing Forward Fold"],
  ["Chaturanga Dandasana", "Low Plank"],
  ["Eka Pada Tadasana", "One-Legged Mountain"],
  ["Ardha Matsyendrasana", "Half Lord of the Fishes"]
]

pose_list.each do |name, description|
  Pose.create(name: name, description: description)
end

user_list = [
  ["Traci", "tracitraci"],
  ["Bryan", "bryanbryan"],
  ["Bob", "bobbobbob"],
  ["Steve", "stevesteve"]
]

user_list.each do |name, password|
  User.create(username: name, password: password)
end
