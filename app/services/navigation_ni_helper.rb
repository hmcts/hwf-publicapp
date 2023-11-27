module NavigationNiHelper
  def no_ni_number_page
    @online_application.ni_number_present == false ? :home_office : :national_insurance
  end

  def ni_related_question?
    case @current_question
    when :national_insurance_presence
      @ni_next_page = no_ni_number_page
    when :national_insurance
      @ni_next_page = :marital_status
    end
  end

  def partner_ni_related_question?
    case @current_question
    when :marital_status
      @partner_ni_next_page = if ucd_apply?(@online_application.calculation_scheme) && @online_application.married
                                :partner_national_insurance
                              else
                                :savings_and_investment
                              end
    end
  end

end