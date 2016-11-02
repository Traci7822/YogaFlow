module ApplicationHelper
  def form_errors_for(object=nil)
    render('layouts/form_errors', object: object) unless object.blank?
  end
end
