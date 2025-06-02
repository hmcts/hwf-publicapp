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
            englishSelect = self.newSelect('Select the child\'s age range','0-13 years','14 years and over');
            welshSelect = self.newSelect('Dewiswch ystod oedran y plentyn','0-13 mlwydd oed',"14 mlwydd oed neu'n hŷn");
            enLabel = self.newLabel("Age range for child " + (numOfChildHTML + 1).toString() + "?");
            welshLable = self.newLabel("Ystod oedran ar gyfer plentyn " + (numOfChildHTML + 1).toString() + "?");

            let lastChildHtmlEnglish = enLabel.prop('outerHTML') + englishSelect.prop('outerHTML');
            let lastChildHtmlWelsh = welshLable.prop('outerHTML') + welshSelect.prop('outerHTML');
            if (languagePicker === 'English'){
                $('#dependent-children-age-panel .children_age_select').last().after(self.newDiv(lastChildHtmlWelsh));
            } else {
                $('#dependent-children-age-panel .children_age_select').last().after(self.newDiv(lastChildHtmlEnglish));
            }
            numOfChildHTML = $('.children_age_select').length;
        }
    },

    newLabel: function(text) {
      const self = this;
      const newLabel = $('<label>', {
          class: 'govuk-label',
          for: 'children_bands',
          text: text
      });
      return newLabel;
    },

    newSelect: function(defaultText, oneText, twoText) {
      const self = this;
      const newSelect = $('<select>', {
        class: 'govuk-select',
        id: 'children_bands[]',
        name: 'dependent[children_bands][]'
      });

      newSelect.append(self.newOption(defaultText,''));
      newSelect.append(self.newOption(oneText,'one'));
      newSelect.append(self.newOption(twoText,'two'));
      return newSelect;
    },

    newOption: function(text, value) {
      const self = this;
      const newOption = $('<option>', {
          value: value,
          text: text
      });
      return newOption;
    },

    newDiv: function(innerHTML) {
      const self = this;
      const newDiv = $('<div>', {
        class: 'govuk-form-group children_age_select'
      });
      return newDiv.html(innerHTML);
    },

};
