class ClearDownstreamQuestions
  def initialize(storage, question)
    @storage = storage
    @question = question
  end

  def for_changes(old_online_application, new_online_application)
    if dependent_change?(new_online_application, old_online_application) ||
       income_kind_change?(new_online_application, old_online_application)
      @storage.clear_forms([:income_range, :income_amount])
    elsif income_range_change?(new_online_application, old_online_application)
      @storage.clear_form(:income_amount)
    elsif benefit_change?(new_online_application)
      @storage.clear_forms([:income_range, :income_amount, :income_kind, :dependent])
    elsif !old_online_application.ni_number_present.nil?
      clear_ni_or_ho(old_online_application)
    end
  end

  def benefit_change?(new_online_application)
    @question == :benefit && new_online_application.benefits == true
  end

  def income_kind_change?(new_online_application, old_online_application)
    @question == :income_kind &&
      old_online_application.income != 0 &&
      new_online_application.income&.zero?
  end

  def income_range_change?(new_online_application, old_online_application)
    (@question == :income_range &&
      old_online_application.income_min_threshold_exceeded !=
        new_online_application.income_min_threshold_exceeded) ||
      old_online_application.income_max_threshold_exceeded !=
        new_online_application.income_max_threshold_exceeded
  end

  def dependent_change?(new_online_application, old_online_application)
    @question == :dependent &&
      old_online_application.children != new_online_application.children
  end

  def clear_ni_or_ho(old_online_application)
    if old_online_application.ni_number_present == false && old_online_application.ni_number
      @storage.clear_form(:national_insurance)
    elsif old_online_application.ni_number && old_online_application.ho_number
      @storage.clear_form(:home_office)
    end
  end
end
