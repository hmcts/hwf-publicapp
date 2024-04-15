class OnBehalfPage < BasePage
  set_url '/questions/applying_on_behalf'

  section :content, '#content' do
    element :header, 'h1', text: 'Is the application on behalf of someone else?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
  end

  def applying_on_behalf
    on_behalf_page.content.yes.click
    continue
  end

  def not_applying_on_behalf
    on_behalf_page.content.no.click
    continue
  end

end
