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
product.photo.attached(io: file_image , file_name: product.name, content_type: 'image/jpg')
product.save
