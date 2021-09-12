import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

export default class extends Controller {
  static targets = ["map", "button"]

  connect() {
    const markers = JSON.parse(this.mapTarget.dataset.markers);
    if (markers.length > 0) {
      mapboxgl.accessToken = this.mapTarget.dataset.mapboxApiKey;
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10'
      });
      markers.forEach((marker) => {
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(map);
      });
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
      map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    } else {
      this.mapTarget.insertAdjacentHTML('afterend', 'No result, no map !')
      this.buttonTarget.classList.add('hidden')
    }
  }

  toggle() {
    if (this.mapTarget.classList.contains('hidden')) {
      this.mapTarget.classList.remove('hidden')
      this.buttonTarget.innerText = 'Hide'
    } else {
      this.mapTarget.classList.add('hidden')
      this.buttonTarget.innerText = 'Display Map'
    }

  }
}