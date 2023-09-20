module PageNavigation

  def store_page_path(page_url, page_name)
    page_path_add({ page_name => page_url })
  end

  def load_step_back(question)
    if page_path.is_a?(Array) && page_path.last.respond_to?(:key?) && page_path.last.key?(question)
      page_path_pop
    elsif (page_index = find_page_index(question)).positive?
      page_path_slice(page_index, page_path.count)
    end

    back_link
  end

  def store
    Rails.cache
  end

  private

  def session_id
    @session['session_id']
  end

  def back_link
    return nil if page_path.blank?

    page_path.last.values.last
  end

  def page_path
    # binding.pry
    Rails.logger.debug "LOGGER: Session cache #{Rails.cache.class}"
    Rails.logger.debug "LOGGER: Session path #{Rails.cache.cache_path}"
    Rails.logger.debug "LOGGER: Session pages: #{store.read("page_path-#{session_id}")}"
    store.read("page_path-#{session_id}") || []
  end

  def page_path_pop
    list = page_path
    list.pop
    store.write("page_path-#{session_id}", list)
  end

  def page_path_slice(from, to)
    list = page_path
    list.slice!(from, to)
    store.write("page_path-#{session_id}", list)
  end

  def page_path_add(page_hash)
    list = page_path
    list << page_hash
    store.write("page_path-#{session_id}", list)
  end

  def find_page_index(question)
    page_path.each_with_index do |page, page_index|
      key = page.keys.first
      return page_index if key == question
    end
    0
  end

end
