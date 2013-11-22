class QuickJob < ActiveRecord::Base
  validates :cats, :presence => true

  def spawn_jobs
    self.all.each do |j|
      j.cats.split(SUPER_SPLITTER).each do |cat|
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
    j.acceptable_categories = acceptable_cats.split(SUPER_SPLITTER).map{ |cat| cat.downcase }
    j.normalize_categories


    build_contact_and_facility(j)




    if j.save
      j
    else
      raise StandardError, "Job is invalid. Messages: #{errors.messages.join(' | ')}"
    end
  end

  def build_contact_and_facility(job)
    contact = Contact.find_or_create_by_contact_string(contact_string)
    f = Facility.new(:contact_id => contact.id)
    f.address.street = street
    f.address.street2 = street2
    f.city = city
    f.state = state.downcase
  end

  public

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

