class JobFormPdf < Prawn::Document
  def initialize(job_form, view)
    super()
    @job_form, @view = job_form, view

    stroke_axis
    bounding_box([0, 900], :width => 600, :height => 100) do
      stroke_bounds
      #stroke_circle([0,0], 10)
    end
  end
end