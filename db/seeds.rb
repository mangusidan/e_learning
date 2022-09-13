User.create!(name: "NVM",
  email: "nvm1301@email.com",
  password: "nvm1301",
  password_confirmation: "nvm1301",
  admin: true
)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
