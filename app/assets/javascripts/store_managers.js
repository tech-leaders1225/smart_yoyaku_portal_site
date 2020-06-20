//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require_tree ./store_managers
//= require moment
//= require fullcalendar

$(function () {
    function eventCalendar() {
        return $('#calendar').fullCalendar({});
    };
    function clearCalendar() {
        $('#calendar').html('');
    };
    $(document).on('turbolinks:load', function () {
    eventCalendar();
    });
    $(document).on('turbolinks:before-cache', clearCalendar);

    $('#calendar').fullCalendar({
    events: '/events.json'
    });
});