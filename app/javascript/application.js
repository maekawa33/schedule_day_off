import "@hotwired/turbo-rails"
import "./controllers"
require("cocoon-js-vanilla")
import Swiper from 'swiper/bundle';
const swiper = new Swiper('.swiper', {

loop: true,
autoplay: {
    delay: 3000,
},

});