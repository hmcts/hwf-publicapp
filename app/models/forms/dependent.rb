module Forms
  class Dependent < Base
    attribute :children, Boolean
    attribute :children_number, Integer

    validates :children, inclusion: { in: [true, false] }
    validates :children_number,
              presence: true, numericality: { allow_blank: true, less_than: 100, greater_than: 0 }, if: :children?

    private

    def export_params
      {
        children: export_children
      }
    end

    def export_children
      if children.nil?
        nil
      elsif children
        children_number
      else
        0
      end
    end
  end
end
