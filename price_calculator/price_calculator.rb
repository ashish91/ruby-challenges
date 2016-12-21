require_relative "item_price"
require_relative "input_formatter"
require_relative "output_formatter"
require_relative "sold_item"
require_relative "item_pricing_logic"

begin
  items = InputFormatter.get_input
  items = items.map{ |name, quantity| SoldItem.new(name: name, quantity: quantity) }
  total_price, saved_price = ItemPricingLogic.calculate_pricing(items)
  OutputFormatter.display_bill(total_price: total_price, saved_price: saved_price, items: items)
rescue InputError => e
  puts "InputError: #{e.message}"
end
