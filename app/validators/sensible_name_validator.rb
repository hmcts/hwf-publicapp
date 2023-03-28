class SensibleNameValidator < ActiveModel::EachValidator
  REGEX = /^[a-zA-ZàèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸåÅæÆœŒçÇøØ ,'-]+$/i

  def validate_each(record, attribute, value)
    return if value.nil? || value == ''

    record.errors.add(attribute, :invalid_name) unless value.match(REGEX)
  end
end
