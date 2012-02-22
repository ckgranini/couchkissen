$ ->
  $(".nav_2").hide()
  $("nav").on "click", "#next", ->
    $(".nav a").fadeToggle()
    $(".nav").toggle()
    if $(this).text() == "▼"
      $(this).text("▲")
    else
      $(this).text("▼")
