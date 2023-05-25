class SensibleIdentifierValidator < ActiveModel::EachValidator
  REGEX = /^[a-zA-Z0-9 \/\\_-]+$/i

  def validate_each(record, attribute, value)
    return if value.nil? || value == ''

    record.errors.add(attribute, :contains_special_chars) unless value.match(REGEX)
  end
end
