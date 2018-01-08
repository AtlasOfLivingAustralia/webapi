if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

var escapeHTML = (function () {
    'use strict';
    var chr = {
        '"': '&quot;', '&': '&amp;', "'": '&#39;',
        '/': '&#47;',  '<': '&lt;',  '>': '&gt;'
    };
    return function (text) {
        if (typeof text !== "string") return "";
        return text.replace(/[\"&'\/<>]/g, function (a) { return chr[a]; });
    };
}());
