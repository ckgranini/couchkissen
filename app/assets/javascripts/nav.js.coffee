$ ->
  array = [".nav_1",".nav_2",".nav_3"]
  i = 0
  $(array[i]).show()
  $("nav").on "click", "#next", ->
    $(array[i]).hide()
    i++
    if i == array.length
        i = 0
    $(array[i]).show()
