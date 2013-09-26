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

function make_selectable(selector, path){
    $(selector).hover(function(){
        $(this).addClass('selected');
    }, function(){
        $(this).removeClass('selected');
    });
    make_linkable(selector, path);
};

function make_linkable(selector, path){
    $(document).on('click', selector, function(){
        var id = $(this).attr('id');
        window.location = path + id;
    });
};

//destroys any element with the id 'tb_modal' when the modal.hidden event fires
$('#tb_modal').on('hidden.bs.modal', function(){
    $(this).detach();
});

function submit_on_enter(form_selector){
    $(document).keypress(function(e){
        if(e.which == 13){
            $(form_selector).submit();
        }
    });
};

//add some sy
