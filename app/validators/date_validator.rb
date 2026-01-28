class DateValidator < ActiveModel::EachValidator
  CHECKS = {
    before: ->(value, boundary) { value < boundary },
    after: ->(value, boundary) { value > boundary },
    before_or_equal_to: ->(value, boundary) { value <= boundary },
    after_or_equal_to: ->(value, boundary) { value >= boundary }
  }.freeze

  def validate_each(record, attribute, value)
    return if options[:allow_blank] && value.blank?

    if value.blank?
      record.errors.add(attribute, :blank)
      return
    end

    validate_boundaries(record, attribute, value)
  end

  private

  def validate_boundaries(record, attribute, value)
    CHECKS.each_key do |check|
      next unless options.key?(check)

      boundary = resolve(options[check], record)
      record.errors.add(attribute, :"date_#{check}") unless CHECKS[check].call(value, boundary)
    end
  end

  def resolve(option, record)
    case option
    when Symbol then record.send(option)
    when Proc then option.call(record)
    else option
    end
  end
end
