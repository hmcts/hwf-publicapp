'use strict';

window.moj.Modules.IncomeSources = {
  sourceDivs: $('.income-sources'),

  init: function() {
    var self = this;

    if(self.sourceDivs.length) {
      self.bindEvents();
    }
  },

  bindEvents: function() {
    var self = this;

    self.sourceDivs.each(function(n, div) {
      var $div = $(div),
          cbs = $div.find('input[type="checkbox"]');

      cbs.each(function(x, cb) {
        if(x === cbs.length - 1) {
          $(cb).on('change', function() {
            if($(cb).is(':checked')) {
              $(cbs).filter(':lt(' + (cbs.length - 1) + ')').prop('checked', false).closest('label').removeClass('selected');
            }
          });
        } else {
          $(cb).on('change', function() {
            if($(cb).is(':checked')) {
              $(cbs[cbs.length - 1]).prop('checked', false).closest('label').removeClass('selected');
            }
          });
        }
      });
    });
  }
};
