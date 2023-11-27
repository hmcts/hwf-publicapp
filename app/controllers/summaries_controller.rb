class SummariesController < ApplicationController
  before_action :redirect_if_storage_unstarted
  after_action :suppress_browser_cache

  def show
    @summary = Views::Summary.new(online_application)
  end
end
