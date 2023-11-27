module Views
  class IncomeKinds
    def initialize(session)
      @session = session
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
      @session.fetch('questions', {}).fetch('income_kind', {})
    end
  end
end
