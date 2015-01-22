//= require jquery
//= require jquery_ujs

/* Code for the search autocomplete */
$(document).ready(function () {
    $.getJSON("/courses/get_courses_json", function( data ) {
        for(var i in data){
            data[i]['label'] = data[i]['acronym'] + ' - ' + data[i]['name'];
        }
        $( "#search" ).autocomplete(
        {
            source:data
        })
    })
});