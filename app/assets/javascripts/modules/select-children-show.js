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

        $('#dependent-children-age-panel .children_age_select').hide();
        $('#dependent-children-age-panel .govuk-fieldset__legend').hide();

        if ($('#dependent_children_number').val() >= 1) {
            $('#dependent-children-age-panel .children_age_select').show();
            $('#dependent-children-age-panel .govuk-fieldset__legend').show();

        }

        $('#dependent_children_number').on('change', function() {
            const numberOfChildren = $(this).val();
            self.updateRangeBoxes(numberOfChildren);
        });
    },

    updateRangeBoxes: function(numberOfChildren) {
        const self = this;
        let languagePicker = $('a.language-picker').text();
        let numOfChildHTML = $('.children_age_select').length;

        $('#dependent-children-age-panel .children_age_select').hide();
        $('#dependent-children-age-panel .govuk-fieldset__legend').hide();

        if (numberOfChildren >= 1) {
            $('#dependent-children-age-panel .children_age_select').show();
            $('#dependent-children-age-panel .govuk-fieldset__legend').show();

        }

        while (numOfChildHTML > numberOfChildren) {
            if(numOfChildHTML === 1) {
                $('#dependent-children-age-panel .children_age_select').hide();
                break;
            }
            $('#dependent-children-age-panel .children_age_select').not(':first').last().remove();
            numOfChildHTML = $('.children_age_select').length;
        }

        while (numberOfChildren > numOfChildHTML) {
            let lastChildHtmlEnglish = "<label class='govuk-label' for='children_bands'>Age range for child " + (numOfChildHTML + 1).toString() + "?</label><select class='govuk-select' id='children_bands[]' name='dependent[children_bands][]'><option value='one'>0-13 years</option><option value='two'>14 years and over</option></select>";
            let lastChildHtmlWelsh = "<label class='govuk-label' for='children_bands'>Ystod oedran ar gyfer plentyn " + (numOfChildHTML + 1).toString() + "?</label><select class='govuk-select' id='children_bands[]' name='dependent[children_bands][]'><option value='one'>0-13 mlwydd oed</option><option value='two'>14 mlwydd oed neu'n hŷn</option></select>";
            if (languagePicker === 'English'){
                $('#dependent-children-age-panel .children_age_select').last().after(self.newDiv(lastChildHtmlWelsh));
            } else {
                $('#dependent-children-age-panel .children_age_select').last().after(self.newDiv(lastChildHtmlEnglish));
            }
            numOfChildHTML = $('.children_age_select').length;
        }
    },

    newDiv: function(innerHTML) {
      const self = this;
      const newDiv = $('<div>', {
        class: 'govuk-form-group children_age_select'
      });
      return newDiv.html(innerHTML);
    },

};
