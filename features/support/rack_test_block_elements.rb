# Capybara's rack_test driver extracts visible text without processing CSS, so
# it spaces text differently from a real browser (cuprite). Two cases bite the
# GOV.UK markup and make browser-passing feature specs fail purely on spacing:
#
#  1. rack_test only inserts whitespace around a subset of block elements (see
#     Capybara::RackTest::Node#displayed_text / BLOCK_ELEMENTS). That list omits
#     dt, dd, li and table cells, so summary-list and table text is run together
#     ("Full nameJohn" instead of "Full name John").
#
#  2. govuk-visually-hidden text (e.g. the label in a "Change" link) is
#     absolutely positioned, so a browser renders whitespace around it
#     ("Change Full name"); rack_test ignores CSS and runs it together
#     ("ChangeFull name").
#
#  3. <br> produces a line break in a browser (e.g. a summary value of
#     "£0<br>Last calendar month" renders as "£0 Last calendar month"), but
#     rack_test has no text node for it so it runs together ("£0Last calendar
#     month"). We emit a newline for it to match.
#
# Mirroring these here makes rack_test text match the browser so the same specs
# pass under both drivers.
module Capybara
  module RackTest
    class Node
      additional_block_elements = %w[
        dt dd li tr td th thead tbody tfoot caption section article aside header footer nav main figure figcaption
      ]
      extended_block_elements = (BLOCK_ELEMENTS + additional_block_elements).uniq.freeze
      remove_const(:BLOCK_ELEMENTS)
      const_set(:BLOCK_ELEMENTS, extended_block_elements)

      module VisuallyHiddenSpacing
        def displayed_text(check_ancestor: true)
          text = super
          return text unless native.element?
          return "\n" if tag_name == 'br'
          return text unless native[:class].to_s.split.include?('govuk-visually-hidden')

          "\n#{text}\n"
        end
      end
      prepend VisuallyHiddenSpacing
    end
  end
end
