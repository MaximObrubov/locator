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

      this.$map = $(`#${self.MAP_DOM_ID}`);
      this.$root = $('body');
      this.moscow = moscow;
      this.nearObjectsUrl = nearObjectsUrl;
      this.initMapOptions = {
        center: [self.moscow.lat, self.moscow.long],
        zoom: 12 // от 0 (весь мир) до 19.
      }

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


    _addPreloader() {
      let self = this;
      this.$preloader = $("<div class='preloader'/>");
      this.$preloader.appendTo(self.$map)
    }


    _getPoint(lat, long, address=null) {
      let opts = {};

      if (address) {
        opts.iconCaption = address
      }
      return new ymaps.Placemark([lat, long], opts);
    }


    _send(data) {
      let self = this;

      console.log(self.nearObjectsUrl);

      $.ajax({
        url: self.nearObjectsUrl,
        method: "POST",
        data: data,
        dataType: "json",
        beforeSend: () => {
          self.$preloader.addClass("shown");
        },
        success: (response) => {
          console.log(response);
        },
        error: (err) => {
          console.err(err);
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
