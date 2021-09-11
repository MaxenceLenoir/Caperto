import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["latitude", "longitude"]
  connect() {
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition((position) => {
        this.latitudeTarget.readOnly = true
        this.latitudeTarget.value = position.coords.latitude.toFixed(2)
        this.latitudeTarget.classList.add("bg-gray-200")
        this.longitudeTarget.readOnly = true
        this.longitudeTarget.value = position.coords.longitude.toFixed(2)
        this.longitudeTarget.classList.add("bg-gray-200")
      })
    }
  }
}
