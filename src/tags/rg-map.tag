<rg-map>
  <section class="map" id="map">
	   <div class="rg-map"></div>
  </section>
	<script>

    function shuffle(array) {
      let currentIndex = array.length, temporaryValue, randomIndex


      while (0 !== currentIndex) {

        randomIndex = Math.floor(Math.random() * currentIndex)
        currentIndex -= 1;
        temporaryValue = array[currentIndex]
        array[currentIndex] = array[randomIndex]
        array[randomIndex] = temporaryValue
      }

      return array;
    }
    let store = shuffle(this.opts.data)

		window.rg = window.rg || {}
		window.rg.gmap = riot.observable({
			initialize: () => {
				window.rg.gmap.trigger('initialize')
			}
		})

		this.on('mount', () => {
			if (!opts.map) opts.map = {
				center: {
					lat: 50.443417,
					lng: 30.521159
				},
				zoom: 12,
        scrollwheel: false,
       navigationControl: false,
       mapTypeControl: false,
       scaleControl: false,
       streetViewControl: false,
       gestureHandling: 'cooperative'
			}



			rg.gmap.on('initialize', () => {
        opts.map.mapObj = new google.maps.Map(this.root.querySelector('.rg-map'), opts.map)
				this.trigger('loaded', opts.map.mapObj)

        let styles = [
          {
              "featureType": "administrative",
              "elementType": "all",
              "stylers": [
                  {
                      "saturation": "-100"
                  }
              ]
          },
          {
              "featureType": "administrative.province",
              "elementType": "all",
              "stylers": [
                  {
                      "visibility": "off"
                  }
              ]
          },
          {
              "featureType": "landscape",
              "elementType": "all",
              "stylers": [
                  {
                      "saturation": -100
                  },
                  {
                      "lightness": 65
                  },
                  {
                      "visibility": "on"
                  }
              ]
          },
          {
              "featureType": "poi",
              "elementType": "all",
              "stylers": [
                  {
                      "saturation": -100
                  },
                  {
                      "lightness": "50"
                  },
                  {
                      "visibility": "simplified"
                  }
              ]
          },
          {
              "featureType": "road",
              "elementType": "all",
              "stylers": [
                  {
                      "saturation": "-100"
                  }
              ]
          },
          {
              "featureType": "road.highway",
              "elementType": "all",
              "stylers": [
                  {
                      "visibility": "simplified"
                  }
              ]
          },
          {
              "featureType": "road.arterial",
              "elementType": "all",
              "stylers": [
                  {
                      "lightness": "30"
                  }
              ]
          },
          {
              "featureType": "road.local",
              "elementType": "all",
              "stylers": [
                  {
                      "lightness": "40"
                  }
              ]
          },
          {
              "featureType": "transit",
              "elementType": "all",
              "stylers": [
                  {
                      "saturation": -100
                  },
                  {
                      "visibility": "simplified"
                  }
              ]
          },
          {
              "featureType": "water",
              "elementType": "geometry",
              "stylers": [
                  {
                      "hue": "#ffff00"
                  },
                  {
                      "lightness": -25
                  },
                  {
                      "saturation": -97
                  }
              ]
          },
          {
              "featureType": "water",
              "elementType": "labels",
              "stylers": [
                  {
                      "lightness": -25
                  },
                  {
                      "saturation": -100
                  }
              ]
          }
      ]

        let markerLibrary = {
        }
        let places = [],
        wine   = 'wine.png',
        craft  = 'craft.png',
        bar    = 'bar.png',
        count = 0;
        for (let value of store) {
          count += 1

          let item = [value.name, value.address.lat, value.address.lng, count, value.category]
          switch(value.category) {
            case 'craft':
              item.push(craft)
              break
            case 'wine':
              item.push(wine)
              break
            case 'bar':
              item.push(bar)
              break
          }
          places.push(item)
        }

      function setMarkers(map) {
        for (let place of places) {
          let myinfowindow = new google.maps.InfoWindow({
              content: '<div id="google-popup">'+ '<p>' + place[0] + '</p>'+'</div>'
          })
          let marker = new google.maps.Marker({
            position: {lat: place[1], lng: place[2]},
            map,
            icon: 'https://kyivplaces.herokuapp.com/' + place[5].toString(),
            title: place[0],
            zIndex: place[3],
            infowindow: myinfowindow
          })
          google.maps.event.addListener(marker, 'click', function() {
            this.infowindow.open(map, this)
          })
          marker.setVisible(false)
          if (!markerLibrary[place[4]]) markerLibrary[place[4]] = []
          markerLibrary[place[4]].push(marker)
        }
      }
      opts.map.mapObj.setOptions({styles})
      setMarkers(opts.map.mapObj)

      let currentInfoWindow = ''
      this.opts.observable.on('highlight', (title, category, count) => {
        if ( count == 0 ) {
          for (mark of markerLibrary[category]) {
            if (title !== mark.title) {
              mark.setVisible(false)
              mark.infowindow.close()


            } else {
              mark.setVisible(true)
              opts.map.mapObj.setCenter(mark.getPosition())
              if (currentInfoWindow && currentInfoWindow === mark.content) {
                mark.infowindow.close()
                currentInfoWindow = ''
              } else {
              mark.infowindow.open(opts.map.mapObj, mark)
              currentInfoWindow = mark.infowindow.content
              }
            }
          }
        } else {
          for (mark of markerLibrary[category]) {
            mark.setVisible(true)
            mark.infowindow.close()
          }
        }

      })

      let previousMarker = ''
      this.opts.observable.on('hideMarker', (marker) => {
        opts.map.mapObj.setCenter(new google.maps.LatLng(50.443417, 30.521159))
        opts.map.mapObj.setZoom(12  )
        for (mark of markerLibrary[marker]) {

          if (!mark.getVisible()) {
            mark.setVisible(true)
          }
        }
        if (previousMarker && previousMarker !== marker) {
          for (mark of markerLibrary[previousMarker]) {
            mark.setVisible(false)
            mark.infowindow.close()
          }
        }
        previousMarker = marker
      })

			})

			if (!document.getElementById('gmap_script')) {

				let script = document.createElement('script')
				script.setAttribute('id', 'gmap_script')
				script.type = 'text/javascript'
				script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyB4ROM_A9U5uATvpsoPmBnSIUG6HIDgFr4&callback=window.rg.gmap.initialize'
				document.body.appendChild(script)
			}
		})

	</script>


  <style>



      .gm-style .gm-style-iw {
         background-color: #888885 !important;
         top: 0 !important;
         left: 0 !important;
         width: 100% !important;
         height: 100% !important;
         min-height: 10px !important;

         display: block !important;
      }


      .gm-style .gm-style-iw #google-popup p{
         padding: 20px;
         text-align: center;
      }

     .gm-style div div div div div div div div {
         background-color: #888885 !important;
         padding: 0;
         margin: 0;
         padding: 0;
         top: 0;
         color: #fff;
         font-size: 16px;
     }


     .gm-style div div div div div div div div a {
         color: #f1f1f1;
         font-weight: bold;
     }

   </style>

</rg-map>
