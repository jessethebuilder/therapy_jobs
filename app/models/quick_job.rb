class QuickJob < ActiveRecord::Base
  validates :cats, :presence => true

  def spawn_jobs
    self.all.each do |j|
      j.cats.split(StringTools::SUPER_SPLITTER).each do |cat|
        raise ArgumentError, "'#{cat}' is not recognized as a category." unless CATEGORIES.keys.include?(cat.downcase)
        new_quick_job = j.dup
        new_quick_job.cats = cat.downcase
        new_quick_job.spawn_job
      end
    end
  end

  private

  def spawn_job
    j = Job.new
    j.category = Category.where(:code => cats)
    j.acceptable_categories = acceptable_cats.split(StringTools::SUPER_SPLITTER).map{ |cat| cat.downcase }
    j.normalize_categories


    build_contact_and_facility(j)




    if j.save
      j
    else
      raise StandardError, "Job is invalid. Messages: #{errors.messages.join(' | ')}"
    end
  end

  def build_contact_and_facility(job)
    contact = Contact.find_or_create_with_contact_string(contact_string)
    f = Facility.new(:contact_id => contact.id)
    f.address.street = street
    f.address.street2 = street2
    f.city = city
    f.state = state.downcase
  end

  public

  def QuickJob.all_to_jobs
    self.all.each do |j|
      j.to_jobs
    end
  end

  def to_jobs
    ret = []
    cats.split(StringTools::SUPER_SPLITTER).each do |category|
      new_qj = self.dup
      new_qj.cats = category
      j = new_qj.to_job
      ret << j.id if j.save!
      @j = j
      @e = @j.errors.messages
      @mf = nil

    end
    ret
  end

  #private

   def to_job
     j = Job.new
     j.category = Category.where(:code => cats.downcase).first
     j.acceptable_categories = acceptable_cats.to_s.downcase.split(StringTools::SUPER_SPLITTER)

     duration_type.downcase == 'perm' ? j.duration_type = 'perm' : j.duration_type = 'contract'
     j.duration = duration || '13'
     j.duration = 0 if duration_type == 'perm'
     #ignoring street
     f = Facility.new(:name => 'quick_job_temp')
     f.setting = Setting.where(:code => setting.downcase).first
     f.address.city = city.to_s.titlecase
     f.address.state = state.to_s.downcase
     f.address.zip = zip
     f.save!
     j.main_facility = f
     j.description = description
     j.private_description = contact_string
     j.contact = Contact.where(:nickname => 'jessefarmer').first

     j.requirements = BoilerPlates.requirements(j)
     j.desirements = BoilerPlates.desirements(j)
     j.benefits = BoilerPlates.benefits(j)
     j.description = BoilerPlates.description(j)
     j
   end

  public

  def QuickJob.reset
    Job.joins(:facilities).where(:facilities => {:name => 'quick_job_temp'}).delete_all
    Facility.where(:name => 'quick_job_temp').delete_all
    QuickJob.delete_all
    QuickJob.import_from_csv
    QuickJob.all_to_jobs
  end

  #CSV stuff
  CSV_PATH = 'C:\Users\jf\Desktop\quick_jobs.csv'

  def QuickJob.import_from_csv
    results = CsvMapper.import(CSV_PATH) do
      map_to QuickJob
      after_row lambda{ |row, person| person.save}
      read_attributes_from_file
    end
  end
end

