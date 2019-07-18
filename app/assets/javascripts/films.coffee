$(document).ready ->

  if document.getElementById('films') != null

    search = ->
      console.log "Search"
      input = document.getElementById('search')
      filter = input.value.toLowerCase()
      table = document.getElementById('film_table')
      tr = table.getElementsByTagName('tr')

      i = 0
      while i < tr.length
        td = tr[i].getElementsByTagName('td')[2]
        if td
          txtValue = td.textContent or td.innerText
          if txtValue.toLowerCase().indexOf(filter) > -1
            tr[i].style.display = ''
          else
            tr[i].style.display = 'none'
        i++

    document.getElementById('search').addEventListener('keyup', search)
    
    sortFavorite = ->
      table = document.getElementById('film_table')
      switching = true
      
      while switching
        switching = false
        rows = table.rows

        i = 1
        while i < rows.length - 1
          shouldSwitch = false

          x = parseInt(rows[i].getAttribute('data-id'))
          y = parseInt(rows[i + 1].getAttribute('data-id'))

          favorites = JSON.parse(localStorage.getItem('favorites'))
          console.log favorites.includes(x.toString()) && !favorites.includes(y.toString())

          if favorites.includes(y.toString()) && !favorites.includes(x.toString())
            shouldSwitch = true
            break
          i++
          
        if shouldSwitch
          rows[i].parentNode.insertBefore rows[i + 1], rows[i]
          switching = true
          
    sortFavorite()
    show_alert = (type) ->
      alertbox = document.getElementById('alert_placeholder')
      if type == 'add'
        alertbox.innerHTML = "<div class='alert alert-success'>Added to favorites</div>"
      else
       alertbox.innerHTML = "<div class='alert alert-danger ' >Removed from favorites</div>"
      setTimeout(
        ()->
          $('.alert').alert('close')
        , 3000)

    handle_fav = (e) ->                     
      e.stopPropagation();

      existing_favorites = JSON.parse(localStorage.getItem('favorites'))
      favorite = this.getAttribute('data-id')

      if existing_favorites.includes(favorite)
        show_alert('remove')
        this.children[0].className= "fa fa-star-o"
        index = existing_favorites.indexOf(favorite)
        existing_favorites.splice(index, 1)
        localStorage.setItem('favorites', JSON.stringify(existing_favorites))
      else
        show_alert('add')
        this.children[0].className= "fa fa-star"
        fav_ids = [].concat.apply([favorite], existing_favorites )
        localStorage.setItem('favorites', JSON.stringify(fav_ids))
      sortFavorite()

    fav_links = document.getElementsByClassName("fav_link");  

    Array.from(fav_links).forEach((element) =>
      id = element.getAttribute('data-id')
      if JSON.parse(localStorage.getItem('favorites')).includes(id)
        element.children[0].className= "fa fa-star"
      element.addEventListener('click', handle_fav, element )

      )

    handle_link = (e) -> 
      return console.log "redirect"
      url = this.getAttribute("data-link")
      window.location = url  

    row_links = document.getElementsByClassName("row_link");

    Array.from(row_links).forEach((element) =>
      element.addEventListener('click', handle_link, element )
      )


  if document.getElementById('film') != null   

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
