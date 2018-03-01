class Hash
  def recursive_symbolize_keys
    {}.tap do |h|
      each { |key, value| h[key.to_sym] = map_value(value) }
    end
  end

  def map_value(value)
    case value
    when Hash
      value.recursive_symbolize_keys
    when Array
      value.map { |v| map_value(v) }
    else
      value
    end
  end
end
