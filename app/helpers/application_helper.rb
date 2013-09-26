module ApplicationHelper
  include FarmTwitterBootstrap
  include FarmAddress::AddressesHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def jsc
    if user_signed_in?
      @jsc ||= current_user.job_search_criterion
    else
      @jsc ||= jsc_for_unknown
    end
  end

  def known_user?
    user_signed_in? || session[:jsc_id]
  end

  private

  def jsc_for_unknown
    jsc = nil
    if session[@jsc_id]
      jsc = JobSearchCriterion.find(@jsc_id) if JobSearchCriterion.exists?(@jsc_id)
    end
    unless jsc
      jsc = JobSearchCriterion.new
      jsc.save
      session[@jsc_id] = jsc.id
    end
    jsc
  end

  #def list_item_builder(list, deliminator = "\n")
  #  html = ''
  #  list.split(deliminator).each do |item|
  #    html += "<li>#{item}</li>"
  #  end if list
  #    html.html_safe
  #end
end