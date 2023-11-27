module Forms
  class PersonalDetail < Base
    attribute :title, String
    attribute :first_name, String
    attribute :last_name, String

    validates :title, length: { maximum: 9 }
    validates :first_name, presence: true, sensible_name: true, length: { maximum: 49 }
    validates :last_name, presence: true, sensible_name: true, length: { maximum: 49 }

    private

    def export_params
      trim_whitespace
      {
        title: title,
        first_name: first_name,
        last_name: last_name
      }
    end

    def trim_whitespace
      self.first_name = first_name.strip if first_name
      self.last_name = last_name.strip if last_name
    end
  end
end
