require_relative 'film'
require_relative 'book'
require_relative 'disk'

class ProductCollection
  PRODUCT_TYPES = {
    film: { dir: 'films', class: Film },
    book: { dir: 'books', class: Book },
    disk: { dir: 'disks', class: Disk }
  }

  def self.from_dir(dir_path)
    products = []
    PRODUCT_TYPES.each do |type, hash|
      product_dir = hash[:dir]
      product_class = hash[:class]
      Dir["#{dir_path}/#{product_dir}/*.txt"].each do |path|
        products << product_class.from_file(path)
      end
    end
    new(products)
  end

  def initialize(products = [])
    @products = products
  end

  def to_a
    @products
  end

  def sort!(params)
    @products.sort_by! { |product| product.send(params[:by]) } if %i[title price amount].include?(params[:by])
    @products.reverse! if params[:order] == :asc
    self
  end

  def to_s
    @products.map.with_index(1) { |product, ind| "#{ind}. #{product}" }.join("\n")
  end

  def product_by_index(chosen_index)
    @products[chosen_index - 1]
  end

  def remove_ended
    @products.select! { |product| product.amount > 0 }
  end

  alias_method :title, :to_s
end
