/**
 * Expand or collapse webservice details.
 */

$(function() {
    //add click events for links
    $( ".webServiceShowDetails" ).click(function() {
        $( this).parent().parent().parent().children( ".webServiceDetails" ).toggle( "slow", function() {
            // Animation complete.
        });
    });
    $('.wsLabel').tooltip({});
});

function expandOnIndividualService(){
    if(window.location.hash) {
        var hash = window.location.hash.substring(1);
        if (hash.startsWith('ws')){
            var section = document.getElementById('webService-details-' + hash.substring(2));
            $(section).show( "slow", function() {
                // Animation complete.
            });
        }
    }
}

function expandApis(){
    $('.webServiceDetails').show( "slow", function() {
    });
}

function collapseApis(){
    $('.webServiceDetails').hide( "slow", function() {
    });
}