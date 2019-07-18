$(document).ready ->

  fav_links = document.getElementsByClassName("fav_links");

  Array.from(fav_links).forEach((element) =>
    element.addEventListener('click', handle_fav, element )
    )

  handle_fav = (elem) ->
    console.log('test')
    elem.stopPropagation();
    elem.children('span').class = "fa fa-star"

    
  handle_link = () -> 
    url = this.getAttribute("data-link")
    window.location = url  

  row_links = document.getElementsByClassName("row_link");

  Array.from(row_links).forEach((element) =>
    element.addEventListener('click', handle_link, element )
    )

  handle_hover= (elem) ->
    url = elem.getAttribute("data-hover")

    fetch(url).then((response) =>
      response.json()
    ).then((data) =>
      elem.innerHTML = data["name"]
      content = "<ul class=list-group>"
      Object.keys(data).forEach((key) =>
        content+= "<li class=list-group-items>#{key}: #{data[key]}</li>"
      )
      content+= "</ul>"

      elem.setAttribute('data-original-title', content)
    )
  
  list_items = document.getElementsByClassName("hover_item");

  Array.from(list_items).forEach((element) =>
    handle_hover(element)
  )

  $("[rel=tooltip]").tooltip({html:true});
