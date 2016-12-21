class InputFormatter
  extend ItemPrice

  class << self
    DELIMITER = ",".freeze

    def get_input
      puts "Please enter all the items purchased separated by a comma"
      input = gets.chomp
      validate_input(input)
    end

    def validate_input(input)
      allowed_items = ITEMS.keys

      grouped_items = group_items(input)
      return raise InputError, "Must input atleast 1 item" if grouped_items.empty?
      wrong_items = grouped_items.keys.select{ |item| !allowed_items.include?(item) }
      return raise InputError, "Items #{wrong_items.join(DELIMITER)} are not allowed" unless wrong_items.empty?

      grouped_items
    end

    def group_items(items_string)
      grouped_items = Hash.new(0)
      items_string.split(DELIMITER).each do |item|
        item = item.strip
        next if item.nil? || item.empty?

        grouped_items[item.strip] += 1
      end
      grouped_items
    end

  end
end

class InputError < StandardError
end
