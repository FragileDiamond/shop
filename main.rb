require_relative '/lib/collection'
require_relative '/lib/cart'

products = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
products.sort!(by: :price, order: :asc)
products.sort!(by: :title)
cart = Cart.new

loop do
  puts products
  puts '0. Выход'
  print '> '
  chosen_number = gets.to_i
  break if chosen_number == '0'

  chosen_product = products.product_by_index(chosen_number.to_i)

  next unless chosen_product
  chosen_product.amount -= 1
  cart.add_to_cart(chosen_product)
  products.remove_ended

  puts <<-OUTPUT

    Вы выбрали #{chosen_product}

    Всего товаров на сумму: #{cart.sum} руб.

  OUTPUT
end

puts <<-CHECK
  Вы купили:

  #{cart}

  С Вас — #{cart.sum} руб. Спасибо за покупки!
CHECK
