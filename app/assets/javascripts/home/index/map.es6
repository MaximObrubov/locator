;((w, $) => {
  class Map {

    constructor(moscow) {
      let self = this;
      this.MAP_DOM_ID = "map";
      if (!moscow && typeof(moscow) !== "object") { throw "Moscow data not passed from server" }
      if (!ymaps) {
        $(`${self.MAP_DOM_ID}`).append("Maps processor not available");
        throw "Maps not available!"
      }

      this.$map = $('#map');
      this.$root = $('body');
      this.moscow = moscow;
      this.initMapOptions = {
        center: [self.moscow.lat, self.moscow.long],
        zoom: 12 // от 0 (весь мир) до 19.
      }
    }


    addMap() {
      let self = this;
      self.map = new ymaps.Map(self.MAP_DOM_ID, self.initMapOptions);
      self.subscribe();
    }

    subscribe() {
      let self = this;
      self.map.events.add('click', function (e) {
        if (!self.map.balloon.isOpen()) {
          let coords = e.get('coords');


          

          // self.map.balloon.open(coords, {
          //     contentHeader:'Событие!',
          //     contentBody:'<p>Кто-то щелкнул по карте.</p>' +
          //         '<p>Координаты щелчка: ' + [
          //         coords[0].toPrecision(6),
          //         coords[1].toPrecision(6)
          //         ].join(', ') + '</p>',
          //     contentFooter:'<sup>Щелкните еще раз</sup>'
          // });
        } else {
          self.map.balloon.close();
        }
      });
    }


    _getPoint(lat, long, address=null) {
      let opts = {};

      if (address) {
        opts.iconCaption = address
      }
      return new ymaps.Placemark([lat, long], opts);
    }




  }


  if (!window.locator) (window.locator = {})
  window.locator.Map = Map;
})(window, jQuery);
