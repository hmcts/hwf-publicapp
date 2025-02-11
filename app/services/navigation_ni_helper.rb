module NavigationNiHelper
  def no_ni_number_page
    @online_application.ni_number_present == false ? :home_office : :marital_status
  end

  def ni_next_question
    if @online_application.applying_on_behalf
      :legal_representative
    else
      :national_insurance
    end
  end

  def ni_related_question?
    next_pages = {
      applying_on_behalf: ni_next_question,
      national_insurance: no_ni_number_page
    }
    @ni_next_page = next_pages[@current_question]
  end

  def partner_ni_related_question?
    case @current_question
    when :marital_status
      @partner_ni_next_page = if @online_application.married
                                :partner_national_insurance
                              else
                                :savings_and_investment
                              end
    end
  end

end
