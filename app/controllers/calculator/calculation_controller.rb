module Calculator
  class CalculationController < ::ApplicationController
    FORM_CLASSES = {
        nil => Forms::Calculator::Nil,
        marital_status: Forms::Calculator::MaritalStatus,
        fee: Forms::Calculator::Fee,
        date_of_birth: Forms::Calculator::DateOfBirth,
        total_savings: Forms::Calculator::TotalSavings,
        benefits_received: Forms::Calculator::BenefitsReceived

    }


    def home
      render locals: { form: form_class.new, current_calculation: current_calculation }
    end

    def edit
      render locals: { form: form_class.new, current_calculation: current_calculation }
    end

    def update
      @form = form_class.new(calculation_params.to_h)
      if @form.valid?
        calculate(@form.export)
        handle_calculation_response
      else
        render :new
      end
    end

    private

    def current_calculation
      @current_calculation = Calculation.new(session.fetch(:calculation) { {} })
    end

    def expire_current_calculation
      @current_calculation = nil
    end

    def calculate(input_data)
      data = current_calculation.inputs.merge(input_data)
      submit_service.call(data)
      expire_current_calculation
      session[:calculation] = submit_service.response.as_json
    end

    def handle_calculation_response
      redirect_to edit_calculator_calculation_url(form: submit_service.response.fields_required.first)
    end

    def form_class
      klass = FORM_CLASSES[params[:form].try(:to_sym)]
      raise "Unknown form class for '#{params[:form]}'" if klass.nil?
      klass
    end

    def calculation_params
      params.require(:calculation).permit(:marital_status, :fee, :date_of_birth, :total_savings)
    end

    def submit_service
      @submit_service ||= SubmitCalculation.new(Settings.submission.url, Settings.submission.token)
    end
  end
end