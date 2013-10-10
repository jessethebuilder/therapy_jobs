module ApplicationHelper
  include FarmTwitterBootstrap
  #include FarmAddress::AddressesHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def known_user?
    user_signed_in? || session[:jsc_id]
  end

  def current_jsc
    if user_signed_in?
      jsc = current_user.job_search_criterion
    elsif session[:jsc_id]
      jsc = JobSearchCriterion.where(:id => session[:jsc_id]).first
    else
      jsc = nil
    end
    jsc || JobSearchCriterion.new
  end

  def for_select(collection, id_method, value_method, selected_ids = nil)
    options = collection.each.collect{ |item| [item.send(id_method), item.send(value_method)] }
    if selected_ids
      options_for_select(options, selected_ids)
    else
      options_for_select(options)
    end
  end

  def line_items(items)
    html = ''
    collection = items.split("\n")
    collection.each do |item|
      html += "<li>#{item}</li>"
    end
    html.html_safe
  end

end

