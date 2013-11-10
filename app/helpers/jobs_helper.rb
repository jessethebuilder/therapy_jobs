module JobsHelper
  include Hacks

  def shared_description
    a = main_facility.address
    s = main_facility.setting
    html = "<div>We are looking for #{articleator(s.name)} for a #{duration} position in #{a.city.titlecase}, #{a.state.upcase}. "
    html += "This positions is #{SETTINGS[s.code][:setting]}. </div>"
    html += "<div>#{read_attribute(:description)} </div>" unless read_attribute(:description).nil?
    html += "<div>We are interested in filling this positions immediately. If you have any interest, please call or email "
    html += "for more details. </div>"
    html.html_safe
  end




end
