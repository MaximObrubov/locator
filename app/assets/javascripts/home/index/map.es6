;((w, $) => {
  class Map {

    constructor(moscow) {
      let self = this;
      this.$root = $('body');
      this.$map = $('#map');
      this.moscow = moscow;
      this.initMapOptions = {
        center: [self.moscow.lat, self.moscow.long],
        zoom: 12 // от 0 (весь мир) до 19.
      }
    }


    addMap() {
      let self = this;
      this.map = new ymaps.Map("map", self.initMapOptions);
    }


    subscribe() {
      this.$map.on("click", function (e) {
        console.log(this);
      });
    }

  }


  if (!window.locator) (window.locator = {})
  window.locator.Map = Map;
})(window, jQuery);
