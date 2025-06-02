'use strict';

window.moj.Modules.SelectionButtonsModule = {
  selectedClass: 'selected',
  focusedClass: 'focused',

  init: function() {
    var self = this,
        $buttons = $("label input[type='radio'], label input[type='checkbox']");

    if($buttons.length) {
      self.bindButtonEvents($buttons);
      $buttons.filter(':checked').each(function(n, el) {
        self.selectElement($(el));
      });
    }
  },

  bindButtonEvents: function($els) {
    var self = this;

    $els.on('click', function(e) {
      var $el = $(e.target);

      if($el.attr('type') === 'checkbox') {
        self.clickCheckbox($el);
      } else {
        self.clickRadio($el);
      }
    }).on('focus blur', function(e) {
      self.focusBlurElement(e);
    });
  },

  clickCheckbox: function($el) {
    var self = this;

    if($el.is(':checked')) {
      self.selectElement($el, true);
    } else {
      self.deselectCheckbox($el);
    }
  },

  clickRadio: function($el) {
    var self = this,
        group = $el.attr('name');

    self.deselectRadio($('input[name="' + group + '"]'));
    self.selectElement($el, true);
  },

  focusBlurElement: function(e) {
    var self = this,
        $el = $(e.target),
        type = e.type;

    if(type === 'focus') {
      self.focusElement($el);
    } else {
      self.blurElement($el);
    }
  },

  deselectCheckbox: function($el) {
    var self = this;

    $el.closest('label').removeClass(self.selectedClass);
    self.focusElement($el);
  },

  deselectRadio: function($els) {
    var self = this;

    $els.each(function(n, el) {
      var $el = $(el);

      $el.closest('label').removeClass(self.selectedClass);
      self.blurElement($el);
    });
  },

  selectElement: function($el, focus) {
    var self = this;

    $el.closest('label').addClass(self.selectedClass);
    if(focus) {
      self.focusElement($el);
    }
  },

  focusElement: function($el) {
    var self = this;

    $el.closest('label').addClass(self.focusedClass);
  },

  blurElement: function($el) {
    var self = this;

    $el.closest('label').removeClass(self.focusedClass);
  }
};
