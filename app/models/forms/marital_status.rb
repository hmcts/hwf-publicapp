module Forms
  class MaritalStatus < Base
    attribute :married, :boolean

    validates :married, inclusion: { in: [true, false] }

    private

    def export_params
      { married: married }
    end
  end
end
