class StepTwentyPage < BasePage
  element :h2, 'h2'
  section :post, '.post' do
    element :p, 'p'
  end
  section :steps_panel, '.steps-panel' do
    element :h2, 'h2'
    elements :li, 'ol > li'
  end
  element :finish_button, '.button'
  sections :li, 'li' do
    section :inset, '.inset' do
      elements :li, 'ul > li'
    end
    element :addresses_panel, '.addresses-panel'
    section :grid_row, '.grid-row' do
      sections :column_half, '.column-half' do
        element :heading_small, '.heading-small'
        section :ul, 'ul' do
          section :email, '.email' do
            elements :li, 'ul > li'
          end
          section :postal_address, '.postal-address' do
            elements :li, 'ul > li'
          end
        end
      end
    end
  end

  def load_page(page_version = nil)
    load(v: page_version)
  end
end
