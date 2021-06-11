module ApplicationHelper
  def ni_number_value(summary)
    summary.ni_number.presence || t('ni_number_no', scope: 'summary.labels')
  end

  def cookies_accepted?
    Forms::Cookie::SettingForm.new(request: request).accepted?
  end

  def show_cookie_banner?
    !Forms::Cookie::SettingForm.new(request: request).preference_set?
  end

  def address_lookup_access_token
    Rails.cache.read('address_lookup')
  end

  def address_lookup_url
    [Rails.configuration.x.address_lookup.endpoint, "/search/places/v1/postcode"].join
  end

  def address_lookup_details_filled?(record)
    record.send("street").present?
  end
end
