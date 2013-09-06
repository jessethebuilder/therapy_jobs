module JobFormsHelper
  include ActionView::Helpers::FormTagHelper
  include ActiveSupport::Inflector

  mattr_accessor :rb_count

  def category_name
    self.job_form_source.category.name
  end

  def source_name
    @source_name ||= self.job_form_source.name
  end

  def title
    html = source_name.titleize
    html += ": #{category_name}" if job_form_source.category
    html.html_safe
  end

  def render_form
    set_up
    html = ''
    self.job_form_source.content.each_line { |line| html += render_line(line) }
    html.html_safe
  end

  def set_up
    @rb_count = 0
  end

  def render_line(line)
    if line.include?(JobFormSource::DEL)
      set_mode(line.chomp)
      html = render_heading
    else
      @question = line.chomp
      html = render_question
    end
    html
  end

  def render_rbg
    html = "<div class='row form-inline light_border'>\n"
    html += "<div class='col-sm-4'><strong>#{@question}</strong></div>\n"
    @answers.each do |answer|
      html += "\t<div class='col-sm-2'>"
        html += radio_button_tag(@question, answer, q_a_hash[@question] == answer, :id => "rb#{@rb_count}")
        html += "<label for='rb#{@rb_count}' class='answer_side'><small>&nbsp;#{answer}</small></label>"
      html += "</div>\n"
      @rb_count += 1
    end
    html += "</div>\n"
    html
  end

  def render_question
    eval("render_#{@mode}")
  end

  def render_heading
    html = "<h2>#{@section_title}</h2>\n"
    html += render_answers if %w|rbg|.include?(@mode)
    html
  end

  def render_answers
    html = "<div class='row answers_row'>"
    html += "<div class='col-sm-4'></div>"
    @answers.each do |answer|
      html += "<div class='col-sm-2'>#{answer}</div>"
    end
    html += '</div>'
    html
  end

  def set_mode(line)
    parts = line.split(JobFormSource::DEL)
    @mode = parts[0]
    @section_title = parts[1]
    @answers = parse_answers(parts[2])
  end

  def parse_answers(answers)
    if /\A\d+\Z/ =~ answers
      ret = saved_answers[Integer(answers)]
    else
      saved_answers << answers
      ret = answers
    end
    ret.split(JobFormSource::SUB_DEL)
  end
end
