class Cart
  def initialize
    @products = []
  end

  def add_to_cart(product)
    @products << product
  end

  def to_s
    @products
      .tally
      .map { |product, count| "#{product.info} X #{count} = #{product.price * count}" }
      .join("\n")
  end

  def sum
    @products.sum(&:price)
  end
end
