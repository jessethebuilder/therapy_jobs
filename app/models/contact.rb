class Contact < ActiveRecord::Base
  belongs_to :client
  has_many :job_form_sources

  has_many :job_locations
  has_many :facilities, :through => :job_locations

  has_many :jobs

  validates :nickname, :uniqueness => true, :allow_nil => true, :allow_blank => true
  validates :email, :uniqueness => true, :allow_nil => true, :allow_blank => true

  def Contact.find_or_create_with_contact_string(contact_string)
    s = contact_string.downcase
    contacts = Contact.where('nickname LIKE ?', s)
    contacts = Contact.where('email LIKE ?', s) if contacts.blank?
    if contacts.blank?
      name_array = s.split(' ')
      contacts = Contact.where('first_name LIKE ?', name_array[0]).where('last_name LIKE ?', name_array[1])
    end

    raise StandardError, "#{contact_string} matched more than one contact." if contacts.count > 1

    if contacts.count == 0
      contact = Contact.create(:nickname => contact_string)
    else
      contact = contacts.first
    end
    contact
  end

  private

end
