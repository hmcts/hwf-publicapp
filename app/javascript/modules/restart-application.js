'use strict';

window.moj.Modules.RestartApplication = {
  button: '.restart-application',
  panel: '.restart-confirm',

  init: function() {
    var self = this;

    self.bindEvents();
  },

  bindEvents: function() {
    var self = this;

    $(self.button).on('click', function(e) {
      var $el = $(e.target);

      e.preventDefault();
      $(self.panel).show();
    });

    $(self.panel).find('.abort').on('click', function() {
      $(self.button).closest('form').submit();
    });

    $(self.panel).find('.cancel').on('click', function() {
      $(self.panel).hide();
    });
  }
};
