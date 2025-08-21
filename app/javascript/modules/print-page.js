'use strict';

window.moj.Modules.PrintPage = {
  init: function() {
    this.bindEvents();
  },

  bindEvents: function() {
    $('a.js-print').on('click', function(e) {
      e.preventDefault();
      window.print();
    });
  }
};
