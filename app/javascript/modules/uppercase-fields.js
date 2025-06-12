'use strict';

window.moj.Modules.UppercaseFields = {
  init: function() {
    var self = this,
        $fields = $('.js-uppercase');

    this.applyTransformClass($fields);
    this.bindEvents($fields);
  },

  applyTransformClass: function($fields) {
    $fields.addClass('transform-upper');
  },

  bindEvents: function($fields) {
    $fields.each(function(n, field) {
      var $field = $(field);
      $field.on('blur', function() {
        $field.val($field.val().toUpperCase());
      });
    });
  }
};
