import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["items", "background"]

  connect() {
    this.backgroundTarget.addEventListener('click', this.close.bind(this));
  }

  disconnect() {
    this.backgroundTarget.removeEventListener('click', this.close.bind(this));
  }


  open(){
    this.itemsTarget.classList.remove('-translate-x-full')
    this.backgroundTarget.classList.remove('hidden'); // Muestra el fondo
  }

  close(){
    this.itemsTarget.classList.add('-translate-x-full')
    this.backgroundTarget.classList.add('hidden'); // Oculta el fondo
  }
}
