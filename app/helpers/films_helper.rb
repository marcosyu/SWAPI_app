module FilmsHelper

  def format_date_time(str)
    DateTime.parse(str).strftime("%B %e, %Y %I:%M %p" )
  end
end
