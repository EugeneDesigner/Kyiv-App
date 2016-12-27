<footer-section>
  <footer>
    <div>
      <a target="_blank" href="http://eugenedeveloper.me/">Check my Website</a>
    </div>
    <div class="footer__icons">
        <a target="_blank" each={icon in icons} class={icon.name} href={icon.link}>
          <img src={'https://kyivplaces.herokuapp.com/' + icon.source}/></a>
    </div>
  </footer>
  <script>
  this.icons = [
    {name: 'facebook', source: 'facebook.svg', link:"https://www.facebook.com/eugeneyar"},
    {name: 'twitter', source: 'twitter.svg', link:"https://twitter.com/"},
    {name: 'vk', source: 'vk.svg', link:"https://vk.com/id9111607"}
  ]

  </script>
</footer-section>
