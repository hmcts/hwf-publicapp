# rubocop:disable Rails/HelperInstanceVariable
module YamlHelper
  include ActionView::Helpers::TagHelper
  include YamlTableHelper

  def display_section(yaml_hash, from = 2, add_to = nil)
    @recursion_level = from
    @this_section = yaml_hash

    @result = add_to || ActiveSupport::SafeBuffer.new
    add_header
    process_collection(:parts) if collection_exists?(:parts)
    process_sections(from) if collection_exists?(:sections)
    @result
  end

  private

  def add_header
    if @this_section[:title].present?
      @result << header_block do
        anchor_tag + header_text
      end
    end
  end

  def header_block(&block)
    tag.send("h#{@recursion_level}", class: header_class) do
      yield block
    end
  end

  def header_text
    tag.span(@this_section[:title])
  end

  def anchor_tag
    tag.a('', name: @this_section[:title].parameterize.underscore)
  end

  def ul_tag_bullet(&block)
    tag.ul(class: 'govuk-list govuk-list--bullet') do
      yield block
    end
  end

  def ul_tag(&block)
    tag.ul(class: 'govuk-list') do
      yield block
    end
  end

  def li_tag(item)
    tag.li(item.html_safe)
  end

  def collection_exists?(name)
    @this_section[name]
  end

  def process_collection(name)
    @this_section[name].each do |part|
      @result << tag_based_list(part)
    end
  end

  def tag_based_list(part)
    return bullet_list_block(part) if part.keys.first == :ul
    return clear_list_block(part) if part.keys.first == :list
    return table_block(part) if part.keys.first == :table

    content_tag(part.keys.first, part.values.first.html_safe, class: 'govuk-body')
  end

  def bullet_list_block(part)
    ul_tag_bullet do
      collect_list_items(part)
    end
  end

  def clear_list_block(part)
    ul_tag do
      collect_list_items(part)
    end
  end

  def collect_list_items(part)
    part.values.first.collect { |item| concat(li_tag(item.values.first)) }
  end

  def process_sections(from)
    @this_section[:sections].each do |subsection|
      display_section subsection, from + 1, @result
    end
  end

  def header_class
    {
      1 => 'govuk-heading-xl',
      2 => 'govuk-heading-l',
      3 => 'govuk-heading-m',
      4 => 'govuk-heading-s'
    }[@recursion_level]
  end

end
# rubocop:enable Rails/HelperInstanceVariable
