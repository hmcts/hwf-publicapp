module Views
  class IncomeThresholds
    def initialize(online_application)
      @online_application = online_application
    end

    def min_threshold
      settings.min_threshold_base + married_supplement + children_supplement
    end

    def max_threshold
      settings.max_threshold_base + married_supplement + children_supplement
    end

    private

    def settings
      Settings.income
    end

    def children_supplement
      children = @online_application.children || 0
      children * settings.per_child_increment
    end

    def married_supplement
      @online_application.married? ? settings.married_supplement : 0
    end
  end
end
