'use strict';

window.moj.Modules.FormName = {
  $identifier: $('#form_name_identifier'),
  $unknown: $('#form_name_unknown'),

  init: function () {
    var self = this;

    if (self.$identifier.length && self.$unknown.length) {
      self.bindEvents();
    }
  },

  bindEvents: function() {
    var self = this;

    self.$identifier.on('keyup', function() {
      self.identifierKeyUp();
    });

    self.$unknown.on('click', function() {
      self.unknownClick();
    });
  },

  identifierKeyUp: function() {
    var self = this;

    if (self.$identifier.val().length > 0 && self.$unknown.is(':checked')) {
      self.$unknown.attr('checked', false).closest('label').removeClass('selected');
    }
  },

  unknownClick: function() {
    var self = this;

    if (self.$identifier.val().length > 0) {
      self.$identifier.val('');
    }
  }
};
