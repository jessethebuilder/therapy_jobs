// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs

//= require twitter/bootstrap

//= require_tree .

function header_height_setter(header_selector){
    $(document).ready(function(){
        $('body').css('padding-top', header_height(header_selector));
//        alert(header_height(header_selector));
//        alert($(header_selector).height());
//        alert($('#top_nav').height());
    });

    $(window).resize(function(){
        $('body').css('padding-top', header_height(header_selector));
    });
};

function header_height(header_selector){
    return $(header_selector).height() + $('#top_nav').height();
};



