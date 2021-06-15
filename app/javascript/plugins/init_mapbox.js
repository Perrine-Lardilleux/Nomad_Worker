import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
// import markerimage from 'images/laptop-house.png';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/perrinelardilleux/ckpmwhlu855nc17kvaltghj1c',
      center: [4, 7.6333],
      zoom: 1.5
    });
    map.scrollZoom.disable();
    map.addControl(new mapboxgl.NavigationControl());

    map.on('load', function () {
      let info = {
        'type': 'geojson',
        'data': {
          'type': 'FeatureCollection',
          'features': []
        }
      }
      const markers = JSON.parse(mapElement.dataset.markers);

      markers.forEach((marker) => {
        info['data']['features'].push({
          'type': 'Feature',
          'properties': {
            'description': marker.info_window,
            'CITY_TYPE': marker.city_type
          },
          'geometry': {
            'type': 'Point',
            'coordinates': [ marker.lng, marker.lat ]
          }
        });
      });
      map.addSource('marker', info);
      // Add symbol for marker
      map.loadImage('https://res.cloudinary.com/dm71o2t6v/image/upload/v1623698592/laptop-house.png', function (error, image) {
        if (error) throw error;
        map.addImage('laptop-house', image);
        // Add a layer showing the places.
        map.addLayer({
          'id': 'marker',
          'type': 'symbol',
          'source': 'marker',
          'layout': {
            'icon-image': 'laptop-house',
            'icon-size': 0.05
            }
          // 'paint': {
          //   'icon-color': [
          //     'match',
          //     ['get', 'CITY_TYPE'],
          //     'cheap','#56ab91',
          //     'normal','#ffac81',
          //     'expensive','#f28482',
          //     '#b09e99'
          //   ],
          // }
        });
      });
      var popup = new mapboxgl.Popup({
        closeButton: false,
        closeOnClick: false
      });

      map.on('mouseenter', 'marker', function (e) {
        // Change the cursor style as a UI indicator.
        map.getCanvas().style.cursor = 'pointer';

        var coordinates = e.features[0].geometry.coordinates.slice();
        var description = e.features[0].properties.description;

        // Ensure that if the map is zoomed out such that multiple
        // copies of the feature are visible, the popup appears
        // over the copy being pointed to.
        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }
        // Populate the popup and set its coordinates
        // based on the feature found.
        popup.setLngLat(coordinates).setHTML(description).addTo(map);
      });

      map.on('mouseleave', 'marker', function () {
        map.getCanvas().style.cursor = '';
        popup.remove();
      });

    });
  };
};

export { initMapbox };
