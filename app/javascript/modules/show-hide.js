'use strict';

window.moj.Modules.ShowHide = {
  init: function() {
    var self = this,
        $elements = $("input[type='radio'].govuk-radios__input , input[type='checkbox'].govuk-checkboxes__input");

    if ($elements.length) {
      self.initCheckElements($elements);
      self.bindElementEvents($elements);
    }
  },

  initCheckElements: function($elements) {
    var self = this;

    $elements.each(function(n, element) {
      var $element = $(element);

      if ($element.is(':checked')) {
        self.toggleElementContent($element);
      }
    });
  },

  bindElementEvents: function($elements) {
    var self = this;

    $elements.on('click', function(e) {
      self.toggleElementContent($(e.target));
    });
  },

  toggleElementContent: function($element) {
    var target = $element.data('target');

    if(target === undefined) {
      $element.closest('form').find('.govuk-radios__input').each(function(n, groupMember) {
        target = $(groupMember).data('target');
        if( target != undefined ) {
          $('#' + target).hide();
        }
      });
    } else {
      $('#' + target).show();
    }
  },

  showContent: function($element, target, show) {
    var $targetElement = $('#' + target);

    $element.attr('aria-expanded', !!show);
    $targetElement.attr('aria-hidden', !show);
    if(show) {
      $targetElement.show();
    } else {
      $targetElement.hide();
    }
  }
};
