class ClearDownstreamQuestions
  def initialize(storage, question)
    @storage = storage
    @question = question
  end

  # TODO: refactor
  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def for_changes(old_online_application, new_online_application)
    if dependent_change?(new_online_application, old_online_application) ||
       income_kind_change?(new_online_application, old_online_application)
      @storage.clear_forms([:income_range, :income_amount])
    elsif income_range_change?(new_online_application, old_online_application)
      @storage.clear_form(:income_amount)
    elsif benefit_change?(new_online_application)
      @storage.clear_forms([:income_range, :income_amount, :income_kind, :dependent])
    elsif legal_representative_changed?(new_online_application, old_online_application)
      clear_legal_representative_details
    elsif over_16_changed?(new_online_application, old_online_application)
      clear_over_16_related_data(new_online_application)
    elsif !old_online_application.ni_number_present.nil?
      clear_ni_or_ho(old_online_application)
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

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

  def legal_representative_changed?(new_online_application, old_online_application)
    return false if @question != :legal_representative || old_online_application.legal_representative.nil?

    new_online_application.legal_representative != old_online_application.legal_representative
  end

  def clear_legal_representative_details
    @storage.clear_form(:legal_representative_detail)
  end

  def over_16_changed?(new_online_application, old_online_application)
    return false if @question != :over_16

    new_online_application.over_16 != old_online_application.over_16
  end

  def clear_over_16_related_data(_new_online_application)
    form = Forms::MaritalStatus.new({ married: false })
    @storage.save_form(form)

    @storage.clear_form(:dob)
    @storage.clear_form(:national_insurance)
    @storage.clear_form(:home_office)
  end
end
