class SensibleAddressValidator < ActiveModel::EachValidator
  REGEX = /^[a-zA-Z0-9 ,'-]+$/i

  def validate_each(record, attribute, value)
    return if value.nil? || value == ''

    record.errors.add(attribute, :invalid_name) unless value.match(REGEX)
  end
end

