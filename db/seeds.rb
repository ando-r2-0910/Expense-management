# coding: utf-8

User.create!(name: "社長 太郎",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

Category.create!(
  name: "食費",
  color: "#ff8ab5",
  user_id: 0
)

Category.create!(
  name: "交通費",
  color: "#8ac1ff",
  user_id: 0
)

Category.create!(
  name: "交際費",
  color: "#8affbb",
  user_id: 0
)

Category.create!(
  name: "その他雑費",
  color: "#d4d4d4",
  user_id: 0
)

Category.create!(
  name: "新聞図書費",
  color: "#fff878",
  user_id: 1
)

Category.create!(
  name: "ガソリン代",
  color: "#ffc273",
  user_id: 1
)

Category.create!(
  name: "資材購入代",
  color: "#c874fc",
  user_id: 2
)
