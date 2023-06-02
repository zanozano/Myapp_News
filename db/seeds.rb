require 'faker'

# Generar 10 usuarios falsos
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save
end

# Obtén todos los usuarios
users = User.all

# Generar 20 artículos con comentarios
20.times do
  article = Article.new(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: users.sample
  )
  article.save

  # Generar entre 1 y 5 comentarios para cada artículo
  rand(1..5).times do
    comment = Comment.new(
      content: Faker::Lorem.sentence,
      user: users.sample,
      article: article
    )
    comment.save
  end
end
