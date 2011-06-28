function show_div(origin,elementId) {
    var posx =$('#'+origin).offset().left + 40;
    var posy =$('#'+origin).offset().top - 2;

    $('#'+ elementId).css({"left":posx});
    $('#'+ elementId).css({"top":posy});
    $('#'+ elementId).toggle();
}

function dropdown_menu(){
    $("#message_menu a, li a").removeAttr('title');
    $("#message_menu ul").css({display: "none"}); // Opera Fix
    $("#message_menu li").each(
        function(){
            var $sublist = $(this).find('ul');//var $sublist = $(this).find(‘ul:first’); original
            $(this).hover(function(){
            $sublist.stop().css({overflow:"hidden", height:"auto", display:"none"}).slideDown(400, function(){
                $(this).css({overflow:"visible", height:"auto", display:"block"});
                });
            },
        function(){
            $sublist.stop().slideUp(400, function(){
            $(this).css({overflow:"hidden", display:"none"});
            });
        });
    });
}

function inbox(){
    //ativa
    $("#menu_inbox").removeClass("message_general_div_option").addClass("message_general_div_option_active");
    //desativa
    $("#menu_outbox").removeClass("message_general_div_option_active").addClass("message_general_div_option");
    $("#menu_trash").removeClass("message_general_div_option_active").addClass("message_general_div_option");
}
function outbox(){
    //ativa
    $("#menu_outbox").removeClass("message_general_div_option").addClass("message_general_div_option_active");
    //desativa
    $("#menu_inbox").removeClass("message_general_div_option_active").addClass("message_general_div_option");
    $("#menu_trash").removeClass("message_general_div_option_active").addClass("message_general_div_option");
}
function trash(){
    //ativa
    $("#menu_trash").removeClass("message_general_div_option").addClass("message_general_div_option_active");
    //desativa
    $("#menu_inbox").removeClass("message_general_div_option_active").addClass("message_general_div_option");
    $("#menu_outbox").removeClass("message_general_div_option_active").addClass("message_general_div_option");
}