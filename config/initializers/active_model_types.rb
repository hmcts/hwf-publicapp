class StrictBooleanType < ActiveModel::Type::Boolean
  def cast(value)
    case value
    when true, "true", "1", 1
      true
    when false, "false", "0", 0
      false
    end
  end
end

class StrictIntegerType < ActiveModel::Type::Integer
  private

  def cast_value(value)
    if value.is_a?(String)
      return nil unless value.strip.match?(/\A-?\d+\z/)
    end
    super
  end
end

class SymbolType < ActiveModel::Type::Value
  def cast(value)
    value&.to_sym
  end
end

class StringArrayType < ActiveModel::Type::Value
  def cast(value)
    case value
    when Array then value.map(&:to_s)
    else []
    end
  end
end

class HashValueType < ActiveModel::Type::Value
  def cast(value)
    value.is_a?(Hash) ? value : nil
  end
end

ActiveModel::Type.register(:boolean, StrictBooleanType)
ActiveModel::Type.register(:strict_integer, StrictIntegerType)
ActiveModel::Type.register(:symbol, SymbolType)
ActiveModel::Type.register(:string_array, StringArrayType)
ActiveModel::Type.register(:hash_value, HashValueType)
