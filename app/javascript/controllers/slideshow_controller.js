import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "slide" ]
  static values = { index: Number }

  next() {
    if (this.slideTargets.length > this.indexValue+1){
    this.indexValue++
    } else {
      this.indexValue = 0
    }
  }

  previous() {
    if (this.indexValue >= 1){
    this.indexValue--
    } else {
      this.indexValue = this.slideTargets.length-1
    }
  }

  indexValueChanged() {
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue
    })
  }

  connect(){
  setInterval(() => {
    this.next()
  }, 3000)
  }

}