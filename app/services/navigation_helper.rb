module NavigationHelper
  include NavigationNiHelper

  private

  def calculation_scheme
    @online_application.calculation_scheme
  end

  def last_question?
    @current_question == QuestionFormFactory.page_list(calculation_scheme).last
  end

  # This need more refactoring
  # rubocop:disable Metrics/MethodLength
  def next_question_id
    if skip_income_questions?
      probate_or_claim
    elsif alternate_question_after_savings?
      @after_savings
    elsif ni_related_question?
      @ni_next_page
    elsif partner_ni_related_question?
      @partner_ni_next_page
    elsif legal_representative?
      @next_page
    elsif over_16?
      @next_page
    else
      question_id
    end
  end
  # rubocop:enable Metrics/MethodLength

  def question_id
    current_question_index = QuestionFormFactory.page_list(calculation_scheme).find_index(@current_question)
    next_id = QuestionFormFactory.page_list(calculation_scheme)[current_question_index + 1]

    if next_id == :probate && !enable_probate?
      :claim
    else
      next_id
    end
  end

  def skip_income_questions?
    skip_income? || skip_income_range? || skip_income_amount?
  end

  def probate_or_claim
    enable_probate? ? :probate : :claim
  end

  def enable_probate?
    !ProbateFeesSwitch.disable_probate_fees?
  end

  def skip_income?
    @current_question == :benefit && @online_application.benefits?
  end

  def skip_income_range?
    @current_question == :income_kind && @online_application.income&.zero?
  end

  def skip_income_amount?
    @current_question == :income_range &&
      (!@online_application.income_min_threshold_exceeded ||
        @online_application.income_max_threshold_exceeded)
  end

  def saving_question?
    @current_question == :savings_and_investment || @current_question == :savings_and_investment_extra
  end

  def alternate_question_after_savings?
    @after_savings = :dependent if @current_question == :savings_and_investment_extra && skip_benefit?
    if skip_savings_and_investment_extra?
      @after_savings = skip_benefit? ? :dependent : :benefit
    end
    @after_savings
  end

  def skip_savings_and_investment_extra?
    @current_question == :savings_and_investment &&
      !@online_application.savings_and_investment_extra_required?
  end

  def skip_benefit?
    @online_application.ho_number.present?
  end

  def skip_apply_type?
    @online_application.refund?
  end

  def legal_representative?
    return false if @current_question != :applying_on_behalf

    @next_page = if @online_application.applying_on_behalf
                   :legal_representative
                 else
                   :national_insurance
                 end
  end

  def over_16?
    return false if @current_question != :over_16

    @next_page = if ucd_apply?(@online_application.calculation_scheme) && @online_application.over_16
                   :national_insurance
                 else
                   :savings_and_investment
                 end
  end

  def ucd_apply?(schema)
    schema == FeatureSwitch::CALCULATION_SCHEMAS[1].to_s
  end

end
