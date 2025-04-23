# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# db/seeds.rb

# db/seeds.rb

require 'open-uri'

Product.destroy_all
User.destroy_all

users = User.create!([
  { email: 'user1@example.com', password: 'password123' },
  { email: 'user2@example.com', password: 'password123' }
])

# Nuevas URLs confiables de imágenes (Unsplash & Wikimedia)
product_data = [
  {
    name: "iPhone 13",
    url: "https://m.media-amazon.com/images/I/71MKNCEgE6L.jpg"
  },
  {
    name: "Samsung Galaxy S22",
    url: "https://image-us.samsung.com/us/smartphones/galaxy-s22/images/gallery/R0-Green/FLRC-214-R0-Green-01-PDP-GALLERY-1600x1200.jpg?$product-details-jpg$"
  },
  {
    name: "Sony WH-1000XM5",
    url: "https://m.media-amazon.com/images/I/61ULAZmt9NL.jpg"
  },
  {
    name: "MacBook Air M2",
    url: "https://m.media-amazon.com/images/I/71S4sIPFvBL.jpg"
  },
  {
    name: "Nintendo Switch",
    url: "https://media.gamestop.com/i/gamestop/11095819/Nintendo-Switch-Console?$pdp$"
  },
  {
    name: "Kindle Paperwhite",
    url: "https://m.media-amazon.com/images/I/51D5he3yCnL._AC_UF1000,1000_QL80_.jpg"
  },
  {
    name: "GoPro HERO11",
    url: "https://m.media-amazon.com/images/I/71xvL9XGwYL.jpg"
  },
  {
    name: "Fitbit Versa 4",
    url: "https://m.media-amazon.com/images/I/618XT1RvyFL.jpg"
  },
  {
    name: "Logitech MX Master 3S",
    url: "https://m.media-amazon.com/images/I/61xKiCADfpL.jpg"
  }
]

users.each do |user|
  product_data.each do |product_info|
    product = Product.create!(
      name: product_info[:name],
      price: rand(150.0..1200.0).round(2),
      stock: rand(5..30),
      status: true,
      description: "Producto de alta calidad: #{product_info[:name]}",
      user: user
    )

    begin
      file = URI.open(product_info[:url])
      filename = File.basename(URI.parse(product_info[:url]).path)
      product.photo.attach(io: file, filename: filename, content_type: 'image/jpeg')
    rescue OpenURI::HTTPError => e
      puts "Error al descargar la imagen para #{product_info[:name]}: #{e.message}"
    end
  end
end

puts "✅ Seed completado: #{User.count} usuarios y #{Product.count} productos con fotos reales en Active Storage."
