class Over16Page < BasePage
  set_url '/questions/over_16'

  section :content, '#content' do
    element :header, 'h1', text: 'Is the person you are applying for over 16?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
  end

  def applicant_over_16
    over_16_page.content.yes.click
    continue
  end

  def applicant_under_16
    over_16_page.content.no.click
    continue
  end

end
