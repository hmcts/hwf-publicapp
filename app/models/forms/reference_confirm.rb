module Forms
  class ReferenceConfirm < Base
    attribute :reference_confirm, Boolean

    validates :reference_confirm, inclusion: { in: [true] }

  end
end
