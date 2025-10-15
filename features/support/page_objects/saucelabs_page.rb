class SaucelabsPage < BasePage
  element :no_income, '.income_kind_applicant_none_of_the_above'
  section :income_sources, '.income-sources' do
    elements :block_label, 'label'
  end
end
