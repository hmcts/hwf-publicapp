module Forms
  class ReferenceConfirm < Base
    attribute :reference_confirm, :boolean

    validates :reference_confirm, inclusion: { in: [true] }
  end
end
