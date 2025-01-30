import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    location: String
  }

  connect() {
    console.log(this.locationValue)
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    if (this.hasLocationValue) {
      this.#zoomToPostcode(this.locationValue)
      this.#addLocationMarker(this.locationValue)
    }

    this.map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }))
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #zoomToPostcode(postcode) {
    fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${postcode}.json?types=postcode&access_token=${this.apiKeyValue}`)
      .then(response => response.json())
      .then((data) => {
        const [lng, lat] = data.features[0].center
        this.map.setCenter([lng, lat])
        this.map.setZoom(9)
      })
  }

  #addLocationMarker(postcode) {
    fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${postcode}.json?types=postcode&access_token=${this.apiKeyValue}`)
      .then(response => response.json())
      .then((data) => {
        const [lng, lat] = data.features[0].center

        // Create a marker and add it to the map
        new mapboxgl.Marker()
          .setLngLat([lng, lat])
          .addTo(this.map)
      })
  }
}
