require 'faker'

99.times do |n|
  name     = Faker::Name.name
  email    = Faker::Internet.email
  nickname = email[/(.*)@/,1]
  avatar   = Faker::Avatar.image 
  password = "password"
  User.create!(name:  name,
               email: email,
               nickname: nickname,
               avatar: avatar,
               password: password,
               password_confirmation: password)
end

# Posts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  image   = Faker::LoremFlickr.image 
  users.each { |user| user.posts.create!(content: content, post_image: image) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }