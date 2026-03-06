import { Controller } from "@hotwired/stimulus"
import Splide from '@splidejs/splide';

export default class extends Controller {
  connect() {
    const slideCount = this.element.querySelectorAll('.splide__slide').length;

    const splide = new Splide(this.element, {
      type   : 'slide',
      perPage: 3,
      focus  : 'center',
      trimSpace: false,
      gap    : '10px',
      arrows : true,
      pagination: false,
      drag   : 'free',
    });

    splide.on('moved', (newIndex) => {
      const activeSlide = splide.Components.Slides.getAt(newIndex).slide;
      const link = activeSlide.querySelector('a');

      if (link) {
        window.Turbo.visit(link.href, {
          frame: "pet_details",
          action: "replace"
        });
      }
    });

    splide.mount();
  }
};
