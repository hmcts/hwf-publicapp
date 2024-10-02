module Views
  class IncomeKinds
    def initialize(session)
      @session = session
    end

    def list_pre
      kinds.map do |kind|
        I18n.t(kind, scope: ['questions.income_kind.kinds'])
      end
    end

    def list
      kinds.map do |kind|
        I18n.t(kind, scope: ['questions.income_kind.kinds'])
      end
    end

    private

    def kinds
      (source.fetch('applicant', []) + source.fetch('partner', [])).tap do |arr|
        arr.uniq!
        arr.sort!
        arr.delete_if { |kind| kind == Forms::IncomeKind.no_income_index }
      end
    end

    def source
      Rails.cache.read("questions-#{@session.id}-income_kind") || {}
    end
  end
end
