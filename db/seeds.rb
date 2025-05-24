require 'open-uri'

# Elimina datos previos
Product.destroy_all
Category.destroy_all
User.destroy_all


# Crea usuarios
users = User.create!([
  { email: 'user1@example.com', password: 'password123' },
  { email: 'user2@example.com', password: 'password123' }
])

# Crea categorías
categories = Category.create!([
  { name: 'technology' },
  { name: 'clothes' },
  { name: 'games' },
  { name: 'sports' },
  { name: 'books' }
])

# Datos de productos
product_data = [
  {
    name: "iPhone 13",
    url: "https://m.media-amazon.com/images/I/71MKNCEgE6L.jpg"
  },
  {
    name: "Samsung Galaxy S22",
    url: "https://m.media-amazon.com/images/I/61jAwWf6GYL.jpg"
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

#Crea productos para cada usuario
users.each do |user|
  product_data.each do |product_info|
    product = Product.create!(
      name: product_info[:name],
      price: rand(150.0..1200.0).round(2),
      stock: rand(5..30),
      status: true,
      description: "Producto de alta calidad: #{product_info[:name]}",
      user: user,
      category_id: categories.sample.id # Asigna una categoría aleatoria
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

puts "✅ Seed completado: #{User.count} usuarios, #{Category.count} categorías, #{Product.count} productos con fotos y categorías."
p categories

require 'open-uri'
require 'json'
url = 'https://api.escuelajs.co/api/v1/products'
html_document = URI.open(url).read
products = JSON.parse(html_document)
product_platzi = products.first

product = Product.create(
  name: product_platzi['title'],
  price: product_platzi['price'],
  stock: rand(0..100),
  status: [true, false].sample,
  description: product_platzi['description'],
  user: users.sample,
  discount: rand(0..40),
  category: categories.sample,
)
file_image = URI.parse(product_platzi['images'][2]).open
product.photo.attach(io: file_image , filename: product.name, content_type: 'image/jpeg')
product.save
p product_platzi['images'][2]
