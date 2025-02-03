'use strict';

window.moj.Modules.SelectChildrenShow  = {

    selectors: {
        selectBox: '#dependent_children_number',
        childrenNumberBox: '#dependent_children_age_band',
        children_age_range_box: 'children_age_range_box',
    },

    init: function() {
        const self = this;

        self.loadRangeBoxes();
        if(document.getElementById(self.selectors.selectBox).length) {
            self.bindEvents();
        }
    },

    bindEvents: function() {
        const self = this;

        document.getElementById(self.selectors.selectBox).on("change", (self.loadRangeBoxes).bind(self));
    },

    loadRangeBoxes: function(e) {
        const self = this;


        let tag_id = document.getElementById(self.selectors.children_age_range_box);
        tag_id.innerHTML = "<%= escape_javascript(render('questions/forms/dependents/child_age_range_box')) %>";

    },
};
