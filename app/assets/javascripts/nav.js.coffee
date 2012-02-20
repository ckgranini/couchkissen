$ ->
  $("#mehr").click ->
    $("#sub-nav").slideToggle()
    if $(this).text() == "Mehr"
      $(this).text("Weniger")
    else
      $(this).text("Mehr")
      