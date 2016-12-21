class SoldItem
  include ItemPrice
  PRICE_SYMBOL = "$".freeze

  attr_reader :name, :unit_price, :sale_price, :sale_quantity
  attr_accessor :price, :quantity
  def initialize(name:, quantity:)
    self.name = name
    self.quantity = quantity

    initialize_item_properties
  end

  def on_sale?
    self.sale_price && self.sale_quantity && self.quantity >= self.sale_quantity
  end

  def price_with_symbol
    "#{PRICE_SYMBOL}#{self.price}"
  end

  private
  attr_writer :name, :unit_price, :sale_price, :sale_quantity

  def initialize_item_properties
    self.unit_price = ITEMS[self.name][:unit_price]
    self.sale_price = ITEMS[self.name][:sale_price]
    self.sale_quantity = ITEMS[self.name][:sale_quantity]
  end

end
