module Forms
  class HelpRequest < Base
    attribute :name, :string
    attribute :email, :string
    attribute :description, :string

    validates :name, :email, :description, presence: true
  end
end
