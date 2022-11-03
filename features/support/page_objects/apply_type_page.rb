class ApplyTypePage < BasePage
  set_url '/questions/apply_type'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 20 of 22'
    element :header, 'h1', text: 'Will you be making your court or tribunal application on paper or using an online service?'
    element :paper, 'label', text: 'Paper'
    element :online, 'label', text: 'Online service'
  end

  def applying_by_paper
    apply_type_page.content.paper.click
    continue
  end

  def applying_by_online_service
    apply_type_page.content.online.click
    continue
  end


end
