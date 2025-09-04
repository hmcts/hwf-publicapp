'use strict';

window.moj.Modules.ExternalLinks = {
  init: function() {
    var self = this;

    self.setupExternalLinks($('a[rel~="external"]'));
  },

  setupExternalLinks: function(obj) {
    obj.each(function(n, el) {
      var $el = $(el),
          winStr = ' (Opens in a new window/tab)',
          currRel = $el.attr('rel'),
          newRel = currRel + ' noopener',
          currTitle = $el.attr('title') ? $el.attr('title') : $el.text(),
          newTitle = currTitle + winStr;

      $el.attr({
        'rel': newRel,
        'target': '_blank',
        'title': newTitle
      }).html($el.html() + '<span class="visuallyhidden">' + winStr + '</span>');
    });
  }
};
