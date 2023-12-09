class ClearDownstreamQuestions
  include ClearPartnerRelatedData

  def initialize(storage, question)
    @storage = storage
    @question = question
  end

  def for_changes(old_online_application, new_online_application)
    @old_online_application = old_online_application
    @new_online_application = new_online_application

    if respond_to?("#{@question}_change?") &&
       send("#{@question}_change?")
      send("#{@question}_clear")
    end
  end

  def dependent_change?
    @question == :dependent &&
      @old_online_application.children != @new_online_application.children
  end

  def dependent_clear
    @storage.clear_forms([:income_range, :income_amount])
  end
  alias income_kind_clear dependent_clear

  def income_kind_change?
    @question == :income_kind &&
      @old_online_application.income != 0 &&
      @new_online_application.income&.zero?
  end

  def income_range_change?
    (@question == :income_range &&
      @old_online_application.income_min_threshold_exceeded !=
        @new_online_application.income_min_threshold_exceeded) ||
      @old_online_application.income_max_threshold_exceeded !=
        @new_online_application.income_max_threshold_exceeded
  end

  def income_range_clear
    @storage.clear_form(:income_amount)
  end

  def benefit_change?
    @question == :benefit && @new_online_application.benefits == true
  end

  def benefit_clear
    @storage.clear_forms([:income_range, :income_amount, :income_kind, :dependent])
  end

  def dob_change?
    !@old_online_application.ni_number_present.nil?
  end

  def dob_clear
    if @old_online_application.ni_number_present == false && @old_online_application.ni_number
      @storage.clear_form(:national_insurance)
    elsif @old_online_application.ni_number && @old_online_application.ho_number
      @storage.clear_form(:home_office)
    end
  end

  def legal_representative_change?
    return false if @question != :legal_representative || @old_online_application.legal_representative.nil?

    @new_online_application.legal_representative != @old_online_application.legal_representative
  end

  def legal_representative_clear
    @storage.clear_form(:legal_representative_detail)
  end

  def applying_on_behalf_change?
    return false if @question != :applying_on_behalf || @old_online_application.applying_on_behalf.nil?

    @new_online_application.applying_on_behalf != @old_online_application.applying_on_behalf
  end

  def applying_on_behalf_clear
    @storage.clear_form(:legal_representative_detail)
    @storage.clear_form(:legal_representative)
  end

  def over_16_change?
    return false if @question != :over_16

    @new_online_application.over_16 != @old_online_application.over_16
  end

  def over_16_clear
    form = Forms::MaritalStatus.new({ married: false })
    @storage.save_form(form)

    @storage.clear_form(:dob)
    @storage.clear_form(:national_insurance)
    @storage.clear_form(:home_office)
  end

  def married_changed?
    return false if @question != :marital_status

    @new_online_application.married != @old_online_application.married
  end

  def married_clear
    clear_partner_data
  end

end
