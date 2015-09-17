// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

var fade_flash = function() {
    $(".alert-notice").delay(5000).fadeOut("slow");
    $(".alert-alert").delay(5000).fadeOut("slow");
    $(".alert-danger").delay(5000).fadeOut("slow");
};
fade_flash();

var show_ajax_message = function(msg, type) {
    $(".flash").html('<div class="alert alert-'+type+'">'+msg+'</div>');
    fade_flash();
};

$(document).ajaxComplete(function(event, request) {
    var msg = request.getResponseHeader('X-Message');
    var type = request.getResponseHeader('X-Message-Type');
    show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want
});