module Hacks
  include ActionView::Helpers::TextHelper

  def standard_description(job)
    html = "We are currently looking for #{articleator(job.category.name)} for a #{duration_parser(job)} in "
    html += facility_addresses_parser(job)
    html += '.'
    html += '<br><br>'
    html += 'New graduates are welcome to apply.' if job.required_experience = 0
    html.html_safe  
  end

  def requirements_parser(job)
    str = ''
    if job.required_experience && job.required_experience > 0
      str += "#{float_to_years_and_months(job.desired_experience)} in the setting\n"
    end
    str += job.requirements.to_s
    str
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

  def duration_parser(job, short = false)
    if job.duration == 0
      if short == true
        return 'Permanent'
      else
        return 'direct-hire, permanent position'
      end
    else
      if short == true
        return 'Contract'
      else
        #todo
        return 'Pluralize!!!'
        #return "#{pluralize(job.duration, 'week')} contract"
      end
    end
  end

  #####################################################333333333333333333333333333

  def add_commas_and_ands(collection, separator = ',')
    #todo this has problems

    str = ''
    counter = collection.count
    if counter == 2
      str += "#{collection[0]} and #{collection[1]}"
    else
      collection.each do |item|
        str += item.to_s
        str += "#{separator} " if counter > 2
        str += "#{separator} and " if counter == 2
        counter -= 1
      end
    end
    str
  end

  def articleator(word, capitalize = false)
    capitalize ? article = 'A' : article = 'a'
    test_word = word.downcase
    %w|honest honor|.each do |an_word|
      article += 'n' if test_word[(0...an_word.length)] == an_word
    end
    article += 'n' if %w|a e i o u|.include?(test_word[0])
    "#{article} #{word}"
  end

  def float_to_years_and_months(float)
    years = Integer(float)
    decimal_months = float - years
    months =  Integer((decimal_months * 12).round)
    #todo
    str = 'Pluralize!!'
    #str = "#{pluralize(years, 'year')}"
    #str += " and #{pluralize(months, 'month')}" unless months == 0
    str
  end

end #Hacks

class Array

  def match_at(regexp_or_string)
    regexp_or_string.class == String ? regex = eval("/#{regexp_or_string}/") : regex = regexp_or_string
    counter = 0
    self.each do |i|
      return counter if i =~ regex
      counter += 1
    end
    nil
  end

end

class ActiveRecord::Base

  #def remove_blank_from_array_attributes(*attrs)
  #  attrs.each do |attr|
  #    if attr_val = self.send(:attr)
  #      arr = eval(attr_val)
  #      write_attribute(attr, arr.delete_if{ |i| i == '' })
  #    end
  #  end
  #end

end
