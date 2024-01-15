User.create!(username: "Example User",
             email: "testema1l@test.org",
             password: "foobarbuz")

User.create!(username: "izach",
             email: "jacobjohn@cobcob.jjj",
             password: "password")


10.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@exampleapi.org"
  password = "password"
  User.create!(username: name,
               email:,
               password:)
end

users = User.order(:created_at).take(6)

10.times do
  users.each do |user|
    title = Faker::Book.title
    description = Faker::Lorem.sentence
    body = Faker::Lorem.paragraphs(number: 3).join(" ")
    article = user.articles.build(title:, description:, body:)
    article.save
  end
end

Favorite.create!(user_id: 1,
                 article_id: 1)

Favorite.create!(user_id: 2,
                 article_id: 1)

Favorite.create!(user_id: 2,
                 article_id: 3)

Article.first.tags.create(name: "dragons")
Article.second.tags.create(name: "dragons")
