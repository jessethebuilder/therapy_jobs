module Hacks
  include ActionView::Helpers::TextHelper
  include StringTools

  def standard_description(job)
    html = "We are currently looking for #{articleator(job.category.name)} for a #{duration_parser(job)} in "
    html += facility_addresses_parser(job)
    html += '.'
    html += '<br><br>'
    html += 'New graduates are welcome to apply.' if job.required_experience = 0
    html.html_safe  
  end

  def requirements_parser(job)
    arr = job.requirements
    if job.required_experience && job.required_experience > 0
      arr << "#{float_to_years_and_months(job.desired_experience)} of experience in the setting\n"
    end
    html = '<ul>'
      html += arr.to_line_items
    html += '</ul>'
    html.html_safe
  end

  def desirements_parser(job)
    str = ''
    if job.desired_experience && job.desired_experience > 0
      str += "#{float_to_years_and_months(job.desired_experience)} in the setting\n"
    end
    str += job.desirements.to_s
    str
  end

  def facility_addresses_parser(job)
    facility_locations = []
    job.facilities.each do |facility|
      address = facility.address
      facility_locations << "#{address.city}, #{address.state.upcase}#{" #{address.zip}" if job.zip_verified? }"
    end
    add_commas_and_ands(facility_locations, ';')
  end

  def facilities_parser(job)
    html = ''
    if job.facilities.count == 1
      html += "The setting of this position is <strong>#{job.facilities.first.setting}</strong>."
    else
      html += "Settings for this position include: <strong>#{facilities_setting_parser(job)}</strong>."
    end
    html.html_safe
  end

  def facilities_setting_parser(job)
    facility_settings = []
    job.facilities.each do |facility|
     facility_settings << facility.setting
    end
    add_commas_and_ands(facility_settings)
  end

  def description_parser(job)
    job.description || standard_description(job)
  end

  def duration_parser(job)
    case job.duration_type
      when 'perm'
        ret = 'Permanent'
      when 'contract'
        ret = "#{job.duration} "
        ret += 'week'.pluralize(job.duration)
    end
    ret
  end

end