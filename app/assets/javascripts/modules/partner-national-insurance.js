'use strict';

window.moj.Modules.FormName = {
    $number: $('#number_input'),
    $no_ni_present_group: $('#partner_ni_checkbox_group'),

    init: function () {
        var self = this;

        if (self.$number.length && self.$no_ni_present_group.length) {
            self.bindEvents();
        }
    },

    bindEvents: function() {
        var self = this;

        self.$number.on('input', function() {
            self.numberKeyUp();
        });

        // Listen for clicks within the checkbox group div
        self.$no_ni_present_group.on('click', function(event) {
            // Check if the click target is the checkbox
            if ($(event.target).is('input[type="checkbox"]')) {
                self.no_ni_presentClick();
            }
        });
    },

    numberKeyUp: function() {
        var self = this;

        if (self.$number.val().trim().length > 0) {
            self.$no_ni_present_group.find('input[type="checkbox"]').prop('checked', false);
        }
    },

    no_ni_presentClick: function() {
        var self = this;

        if (self.$no_ni_present_group.find('input[type="checkbox"]').is(':checked')) {
            self.$number.val('');
        }
    }
};

$(document).ready(function() {
    window.moj.Modules.FormName.init();
});
