module BoilerPlates
  extend StringTools

  def self.requirements(job)
    arr = ["Current license to work as a #{job.licensed_categories} in #{ZipDistance::STATES[job.main_facility.address.state]}."]
    arr
  end

  def self.desirements(job)
    arr = ["Two years of experience #{job.main_facility.setting.setting_clause}."]
    arr
  end

  def self.benefits(job)
    arr = ['Competitive pay']
    arr << 'Medical and Dental'
    arr << 'CEU Reimbursement'
    arr << 'Relocation Assistance'

    if job.duration_type == 'contract'
      arr << 'Housing, food, and travel allowance'
    end
    arr
  end

  def self.description(job)
    html = "We are currently looking for #{articleator(job.category.name)} "
    html += "for a #{DURATION_TYPES[job.duration_type.downcase][:name].titlecase} position in "
    html += "#{job.main_facility.address.city.titlecase}, #{job.main_facility.address.state.upcase}."
    html += '<br><br>'
    html += "This position is #{job.main_facility.setting.setting_clause}, and we are hoping for someone with experience "
    html += "in that setting, though new graduates are welcome to apply."
    html
  end

end

module Hacks
  include ActionView::Helpers::TextHelper
  include StringTools

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