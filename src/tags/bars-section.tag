<bars-section id="places">
   <h3 show={!this.opts.store.getState().length}>Сначало выбери карту, а там мы тебе и расскажем о самых интересных местах</h2>
<ul>
  <li each={item in this.opts.store.getState()} onClick={highlightItem} id={item.category + ',' + item.name} class={item.name}>
    <h4> {item.name}</h4>
    <p>{item.description} </p>
    <div class="icons">
      <span class="marker" onClick={mapView}><image src={'https://kyivplaces.herokuapp.com/marker.svg'}/></span>
      <a target='_blank' href={item.link}>Вперед к открытиям</a>
  </div>
  </li>
</ul>

  <script>
      let map = document.getElementById('map')

      mapView() {
        map.scrollIntoView()
      }
      this.opts.store.subscribe(function(){
        this.update()
      }.bind(this))


    var previousElement = ''
    let previousCategory = ''
    let count = 0
    let previousItem = ''
    highlightItem(e) {
      let highlightElement, highlightCategory

      let element = e.target.id|| e.target.parentNode.id
      let item = document.getElementById(element).classList
      element = element.split(',')
      if (previousElement && element[1] === previousElement && count === 0) {
        count = 1
        previousItem.remove('highlight')
        this.opts.observable.trigger('highlight', previousElement, previousCategory, count)

      } else {
        count = 0
        item.toggle('highlight')
        console.log(item)
        if (previousItem && item !== previousItem) {
          previousItem.remove('highlight')
        }
        this.opts.observable.trigger('highlight', element[1], element[0], count)
        previousElement = element[1]
        previousCategory = element[0]
        previousItem     = item

      }




    }


    function closestById(el, id) {
  while (el.id != id) {
    el = el.parentNode;
    if (!el) {
      return null;
    }
  }
  return el;
}


  </script>
</bars-section>
