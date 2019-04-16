;((w, $) => {
  class Map {

    constructor(moscow, nearObjectsUrl) {
      let self = this;
      this.MAP_DOM_ID = "map";
      if (!moscow && typeof(moscow) !== "object") { throw "Moscow data not passed from server" }
      if (!ymaps) {
        $(`${self.MAP_DOM_ID}`).append("Maps processor not available");
        throw "Maps not available!"
      }

      this.$root = $('body');
      this.$map = $(`#${self.MAP_DOM_ID}`);
      this.$results = this.$root.find(".js-results");
      this.moscow = moscow;
      this.nearObjectsUrl = nearObjectsUrl;
      this.initMapOptions = {
        center: [self.moscow.lat, self.moscow.long],
        controls: [],
        zoom: 12 // от 0 (весь мир) до 19.
      }
      this.housesCollection = null;

    }


    addMap() {
      let self = this;
      self.map = new ymaps.Map(self.MAP_DOM_ID, self.initMapOptions);
      self._addPreloader();
      self.subscribe();
    }

    subscribe() {
      let self = this;
      self.map.events.add('click', function (e) {
        if (!self.map.balloon.isOpen()) {
          let coords = e.get('coords')
          self._send({lat: coords[0], long: coords[1]});
        } else {
          self.map.balloon.close();
        }
      });
    }


    _addPreloader() {
      let self = this;
      this.$preloader = $("<div class='preloader'/>");
      this.$preloader.appendTo(self.$map)
    }


    _getPoint(lat, long, address=null) {
      let opts = {};
      if (address) { opts.hintContent = address; }
      return new ymaps.Placemark([lat, long], opts);
    }


    _send(data) {
      let self = this;

      $.ajax({
        url: self.nearObjectsUrl,
        method: "POST",
        data: data,
        dataType: "json",
        beforeSend: () => {
          self.$preloader.addClass("shown");
        },
        success: (response) => {
          if (response.html) {
            self.$results.html(response.html)
          }
          if (response.houses) {

            if (self.housesCollection) {self.housesCollection.removeAll()}

            self.housesCollection = new ymaps.GeoObjectCollection(null, {
              preset: 'islands#yellowIcon'
            }),
            response.houses.forEach((h) => {
              let house = h.instance,
                  pointMark = self._getPoint(house.lat, house.long, house.address);
                self.housesCollection.add(pointMark);
            })
            self.map.geoObjects.add(self.housesCollection);
          }
        },
        error: (err) => {
          console.error(err);
        },
        complete: () => {
          self.$preloader.removeClass("shown");
        }
      });
    }


  }


  if (!window.locator) (window.locator = {})
  window.locator.Map = Map;
})(window, jQuery);
