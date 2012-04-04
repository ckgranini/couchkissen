module MoviesHelper
  def get_width
    width = params[:width]
    if width == "1"
      width = "w45"
    elsif width == "2"
      width = "w92"
    elsif width == "3"
      width = "w150"
    elsif width == "4"
      width = "w185"
    elsif width == "original"
      width = "original"
    else
      width = "w92"
    end
  end
end
