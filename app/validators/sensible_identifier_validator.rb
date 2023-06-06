class SensibleIdentifierValidator < ActiveModel::EachValidator
  REGEX = %r{^[a-zA-Z0-9 /\\_-]+$}

  def validate_each(record, attribute, value)
    return if value.nil? || value == ''

    record.errors.add(attribute, :contains_special_chars) unless value.match(REGEX)
  end
end
