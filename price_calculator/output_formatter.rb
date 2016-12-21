class OutputFormatter
  class << self

    LINE_WIDTH = 30.freeze
    FIELD_WIDTH = 10.freeze
    HEADERS = ["Item", "Quantity", "Price"]

    def display_bill(total_price:, saved_price:, items:)
      puts
      draw_headers
      draw_bill(items)

      puts
      puts "Total Price: #{SoldItem::PRICE_SYMBOL}#{total_price}"
      puts "You Saved: #{SoldItem::PRICE_SYMBOL}#{saved_price}"
    end

    def draw_headers
      draw_table_line(HEADERS)
      puts "-" * LINE_WIDTH
    end

    def draw_bill(items)
      items.each{ |item| draw_table_line([ item.name, item.quantity, item.price_with_symbol ]) }
    end

    def draw_table_line(table_items)
      line_items = table_items.map{ |table_item| "#{table_item}#{" " * (FIELD_WIDTH - table_item.to_s.length)}" }
      puts line_items.join
    end

  end
end
