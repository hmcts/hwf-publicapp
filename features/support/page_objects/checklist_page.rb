class ChecklistPage < BasePage
  set_url '/checklist'

  section :content, '#content' do
    element :header, 'h1', text: 'What you will need'
    element :list_item_ni_number, 'li', text: 'your National Insurance number'
    element :list_item_ho_number, 'li', text: 'your Home Office reference number – you may have a Home Office reference number if you are subject to immigration control'
    element :list_item_form_number, 'li', text: 'the court or tribunal form number'
    element :list_item_case_number, 'li', text: 'your case number, claim number or notice to pay - if you have one'
    element :use_paper_form, 'p', text: 'If you don\'t have either a National Insurance number or a Home Office reference number, you need to use the paper form and apply to the court or tribunal by post or email.'
    element :use_paper_form_link, 'a', text: 'use the paper form'
    elements :do_not_know, 'span'
    element :look_for_ni, 'li', text: 'look for your National Insurance number on payslips or official letters about tax, pensions or benefits'
    element :look_ho, 'li', text: 'You will find your Home Office reference number on any of the correspondence you have received from the Home Office.'
    element :reminder, 'a', text: 'ask for a reminder through the post'
    element :look_for_ho, 'li', text: 'You will find your Home Office reference number on any of the correspondence you have received from the Home Office.'
  end

  def click_do_not_know
    content.do_not_know[0].click
  end

  def click_do_not_know_2
    content.do_not_know[1].click
  end

end
