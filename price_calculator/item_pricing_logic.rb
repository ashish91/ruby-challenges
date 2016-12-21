class ItemPricingLogic
  class << self

    def calculate_pricing(purchased_items)
      total_price = 0.00
      saved_price = 0.00
      purchased_items.each do |item|
        actual_price = item.quantity * item.unit_price
        if item.on_sale?
          discounted_price = item.sale_price
          remaining_price = (item.quantity - item.sale_quantity) * item.unit_price
          item.price = discounted_price + remaining_price

          saved_price += (actual_price - item.price).round(2)
        else
          item.price = actual_price
        end
        total_price += item.price
      end

      [ total_price, saved_price ]
    end

  end
end
