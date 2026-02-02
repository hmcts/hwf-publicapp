module Forms
  class BaseRange < Base
    attribute :choice, :symbol

    validates :choice, inclusion: { in: %i[less between more] }

    private

    def export_params
      case choice
      when :less
        { min_threshold_name => false }
      when :between
        { min_threshold_name => true, max_threshold_name => false }
      when :more
        { min_threshold_name => true, max_threshold_name => true }
      else
        {}
      end
    end
  end
end
