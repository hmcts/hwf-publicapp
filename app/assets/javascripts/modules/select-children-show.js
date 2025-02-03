'use strict';

window.moj.Modules.SelectChildrenShow  = {

    selectors: {
        childrenNumberBox: '#dependent_children_age_band',
        children_age_range_box: 'children_age_range_box',
    },

    init: function() {
        const self = this;

        self.bindEvents();

    },

    bindEvents: function() {
        const self = this;
        $('#dependent_children_number').on('change', function() {
            const numberOfChildren = $(this).val();
            console.log('Children number select changed to:', numberOfChildren);
            self.updateRangeBoxes(numberOfChildren);
        });
    },

    updateRangeBoxes: function(numberOfChildren) {
      const self = this;
      const oneChildHtml = $('.children_age_select').first().html();

      $('#dependent-children-age-panel .children_age_select').not(':first').remove(); // Clear existing appended elements

      // // numberOfChildrenSelects = numberOfChildren -1
      for (let i = 0; i < numberOfChildren; i++) {
        $('#dependent-children-age-panel .children_age_select').last().after(self.newDiv(oneChildHtml));
      }
    },

    newDiv: function(innerHTML) {
      const self = this;
      var newDiv = $('<div>', {
        class: 'govuk-form-group children_age_select'
      });
      return newDiv.html(innerHTML);
    },

};
