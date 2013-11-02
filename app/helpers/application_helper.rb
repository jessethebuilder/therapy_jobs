module WebBasics
  def for_select(collection, id_method, value_method, selected_ids = nil)
    options = collection.each.collect{ |item| [item.send(id_method), item.send(value_method)] }
    if selected_ids
      options_for_select(options, selected_ids)
    else
      options_for_select(options)
    end
  end
end

module ApplicationHelper
  include FarmTwitterBootstrap
  include WebBasics

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

  def jsc_form_link
    known_user? ? 'edit_job_search_criterion' : 'new_job_search_criterion'
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


  def line_items(items)
    html = ''
    collection = items.split("\n")
    collection.each do |item|
      html += "<li>#{item}</li>"
    end
    html.html_safe
  end

  def spacer(pixel_count = 100, float = 'left', options = {})
    html = "<div style='float:"
    html += float
    html += " width:"
    html += String(pixel_count)
    html += "'"
    html += option_hash_to_html(options)
    html += ">&nbsp;</div>"
    html.html_safe
  end

  private

  def option_hash_to_html(options)
    html = ''
    options.each do |k, v|
      html += " #{k}='#{v}'"
    end
    html
  end

end

