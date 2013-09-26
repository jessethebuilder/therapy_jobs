module DeviseHelper
  def show_modal(partial_name)
    js = "$('#tb_modal').modal('hide');"
    js += "$('#tb_modal').on('hidden.bs.modal', function(){"
      js += "$('body').append('<%= j render :partial => "
      js += partial_name
      js += "' %>');"
      js += "$('#tb_modal').modal('show');"
    js += "});"
    js
  end







end