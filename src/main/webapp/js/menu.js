(function($) {
    let first_child_user_menu = $("#user-menu li:first-child");
    let last_child_user_menu = $("#user-menu li:last-child");
    // console.log(first_child_user_menu);
    // console.log(last_child_user_menu);
    first_child_user_menu.click(function(){
        if(last_child_user_menu.is(":visible")){
            $("#user-menu li:nth-child(2)").hide();
            $("#user-menu li:nth-child(3)").hide();
            last_child_user_menu.hide();
        }else{
            $("#user-menu li:nth-child(2)").fadeIn(500);
            $("#user-menu li:nth-child(3)").fadeIn(500);
            last_child_user_menu.fadeIn(500);
        }
    });
})( jQuery );