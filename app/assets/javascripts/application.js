//= require jquery
//= require jquery_ujs
//= require materialize.min

/* Code for the search autocomplete */
$(document).ready(function () {
    $.getJSON("/courses/search", function( data ) {
        for(var i in data){
            data[i]['label'] = data[i]['acronym'] + ' - ' + data[i]['name'];
        }
        $( "#search" ).autocomplete(
        {
            source:data
        })
    })

    $(".button-collapse").sideNav();
});