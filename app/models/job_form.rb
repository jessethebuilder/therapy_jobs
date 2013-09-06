class JobForm < ActiveRecord::Base
  include JobFormsHelper

  attr_accessor :saved_answers, :mode, :section_title, :answers, :question, :all_answers
  belongs_to :user
  belongs_to :job_form_source

  validates :job_form_source, :presence => true
  validates :user, :presence => true

  serialize :q_a_hash, Hash

  def saved_answers
    @saved_answers ||= []
  end

  def save_answers(hash)
    #new_hash = {}
    #hash.each do |k, v|
    #  new_hash[k] = v if all_questions.include?(k)
    #end
    #self.q_a_hash = new_hash

    h = hash.dup
    h.delete(:utf8)
    h.delete(:authenticity_token)
    h.delete(:commit)
    h.delete(:controller)
    h.delete(:action)
    h.delete(:id)
    self.q_a_hash = h
    self
  end
  
  def all_questions
    if @all_questions
      @all_questions
    else
      @all_questions = []
      job_form_source.content.each_line do |l|
        @all_questions << l unless l.include?(JobFormSource::DEL)
      end
      @all_questions
    end
  end
  
  def JobForm.for_user(user, name, code, *args)
    find_for_user(user, name, code) || create_for_user(user, name, code, *args)
  end

  def JobForm.find_for_user(user, name, code)
    category_id = Category.where(:code => code).first.id if code
    user.job_forms.joins(:job_form_source).where(:job_form_sources => {:name => name, :category_id => category_id}).first
  end

  def JobForm.create_for_user(user, name, code, *args)
    job_form = user.job_forms.new(*args)
    category_id = Category.where(:code => code).first.id if code
    job_form.job_form_source = JobFormSource.where(:name => name, :category_id => category_id).first
    job_form.save
    job_form
  end

end
