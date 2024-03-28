module NavigationNiHelper
  def no_ni_number_page
    @online_application.ni_number_present == false ? :home_office : :national_insurance
  end

  def ucd_no_ni_number_page
    @online_application.ni_number_present == false ? :home_office : :marital_status
  end

  def ucd_ni_next_question
    if ucd_apply?(@online_application.calculation_scheme) && !@online_application.applying_on_behalf
      :national_insurance
    else
      :legal_representative
    end
  end

  def ni_related_question?
    next_pages = {
      applying_on_behalf: ucd_ni_next_question,
      national_insurance_presence: no_ni_number_page,
      national_insurance: ucd_no_ni_number_page
    }
    @ni_next_page = next_pages[@current_question]
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
