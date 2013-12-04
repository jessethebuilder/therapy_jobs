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

function makeSelectable(selector, path){
    $(selector).hover(function(){
        $(this).addClass('selected');
    }, function(){
        $(this).removeClass('selected');
    });
    makeLinkable(selector, path);
};

function makeLinkable(selector, path){
    $(document).on('click', selector, function(){
        var id = $(this).attr('id');
        window.location = path + id;
    });
};



function submitOnEnter(form_selector){
    $(document).keypress(function(e){
        if(e.which == 13){
            $(form_selector).submit();
        }
    });
};

function addError(selector, message){
    $(selector).addClass('has-error');
    $(selector).append('<span class="help-block">' + message + '</span>');
};

function linkBuilder(link, link_builder_fields){
    for(var i=0;i<link_builder_fields.length;i++){
        clickOnEnterIfFocused(link, link_builder_fields[i]);
    };
    addTextFieldsToAjaxLink(link, link_builder_fields);
};
function addTextFieldsToAjaxLink(link, text_field_selectors){
    $(link).click(function(e){
        e.preventDefault();
        var url = '';
            for(var i=0;i<text_field_selectors.length;i++){
                  if($(text_field_selectors[i]).val().length > 0){
                      url += '/';
                      url += $(text_field_selectors[i]).val();
                  }
            }
        $.ajax($(link).attr('href') + url);
    })   //does this twice
}
function clickOnEnterIfFocused(link, focused_field){
    $(document).keypress(function(e){
        if(e.which == 13){
            if($(focused_field).is(":focus")){
                e.preventDefault();
                $(link).click();
            }
        }
    })
};
