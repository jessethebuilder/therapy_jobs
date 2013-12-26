module JobFormSeed

  def checklist_setup(code)
    jfs = JobFormSource.new
    jfs.contact = Contact.first
    jfs.name = "skills_checklist"
    file = File.open "#{Rails.root}/db/job_form_dat/#{code}_skills.txt"
    #file = File.open("C:\\Users\\jf\\Desktop\\jesseweb\\therapy_jobs\\db\\job_form_dat\\#{code}_skills.txt")
    jfs.content = file.read
    jfs.category = Category.where(:code => code).first
    jfs.save
    jfs
  end

end