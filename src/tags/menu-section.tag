<menu-section class="menu__icons">
  <div class="menu__mobile">
    <ul>
      <li each={item in menus} id={'mobile' + item.key} onClick={() => changePlaces(item.key)} class={item.key}><span class="here">Уже в</span> <span class="there">Еще не в </span>{item.name}</li>
    </ul>
  </div>
  <article each={item in menus} id={item.key} onClick={() => changePlaces(item.key)}>
    <a  class={item.key} href="#"><image src={'https://kyivplaces.herokuapp.com/' + item.picture}/></image></a>
    <div class="icon__description">{item.name}</div>
  </article>

  <script>
    let previousItem = ''
    let opened = false
    changePlaces(item) {
      if (!opened) {
        opened = true
        document.querySelector('.menu__mobile').style.display = 'block'
      }
      if (previousItem && previousItem !== item) {
          document.querySelector('#'+previousItem).classList.remove('selected')
            document.querySelector('#mobile'+previousItem).classList.remove('selected')

      }
      document.querySelector('#'+item).classList.add('selected')
      document.querySelector('#mobile'+item).classList.add('selected')
      previousItem = item
      this.opts.store.dispatch({type:'CHANGE_PLACE', state: this.opts.store.getState(), key:item})
      this.opts.observable.trigger('hideMarker', item)
      document.getElementById('places').scrollIntoView()
    }




    this.menus = [
      {name: 'Атмосферном баре', picture: 'icon_beer.svg', key:"bar"},
      {name: 'Крафтовом тайнике', picture: 'icon_craft.svg', key:"craft"},
      {name: 'Винном погребе', picture: 'icon_wine.svg', key:"wine"}
    ]


  </script>


</menu-section>
