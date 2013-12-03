module ApplicationHelper
  include HtmlTools

  def management_position_codes
    arr = CATEGORIES.keys
    STANDARD_CATEGORIES.each{ |code| arr.delete(code) }
    arr
  end

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



  #todo refactor to FarmTools

  def developer_note(content)
    html = '<div class="developer_note">'
      html += '<strong>Developer Note:</strong> '
      html += content
    html += '</div>'
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

class Array
  #todo refactor to FarmTools
  def to_line_items
    html = ''
    self.each do |item|
      html += "<li>#{item}</li>"
    end
    html.html_safe
  end
end
