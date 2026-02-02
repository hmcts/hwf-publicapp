module NullifyBlank
  extend ActiveSupport::Concern

  included do
    class << self
      def attribute(name, type = nil, **options)
        super
        return unless type == :boolean

        define_method(:"#{name}?") do
          public_send(name)
        end
      end
    end
  end

  def [](key)
    public_send(key)
  end

  def []=(key, value)
    public_send(:"#{key}=", value)
  end

  def attributes
    super.with_indifferent_access
  end

  def assign_attributes(new_attributes)
    super(nullify_blanks(new_attributes))
  end

  private

  def nullify_blanks(attributes)
    return {} if attributes.blank?

    attributes.to_h.transform_values do |value|
      value.is_a?(String) && value.blank? ? nil : value
    end
  end
end
