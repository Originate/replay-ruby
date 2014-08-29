module ReplayApi
  module CompactAttributes
    def compact_attributes
      compact(attributes)
    end

    private

    def compact(input)
      input.each_with_object({}) do |(key, value), hash|
        next if value.nil?
        if value.is_a? Hash
          new_value = compact(value)
          next if new_value.empty?
          hash[key] = new_value
        elsif value.is_a? Model
          new_value = value.compact_attributes
          next if new_value.empty?
          hash[key] = new_value
        else
          hash[key] = value
        end
      end
    end
  end
end
