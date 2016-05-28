jQuery(document).ready(function() {
    App.init();
    new WOW().init();
    App.initCounter();
    App.initParallaxBg(); 

    // search form placeholder fix
    $('input').focus(function(){
       $(this).data('placeholder',$(this).attr('placeholder'))
           .attr('placeholder','');
    }).blur(function(){
       $(this).attr('placeholder',$(this).data('placeholder'));
    });

    $("#alert").validate({
        ignore: ":hidden",
         rules: {   },

        submitHandler: function (form) {

             $.ajax({
                type: "POST",
                dataType:"json",
                url: "controller/addalert.cfm",
                data: $(this).serialize()
            }).done(function(){
                $('#emailform').html(
                    "<div class='col-xs-12'><h2>Sweet! You're Almost Done.</h2><p>To activate your job alert, please check your email and click the confirmation button.</p></div>");
            }).fail(function(){
                      $('#emailform').html(
                    "<div class='col-xs-12'><h2>Sorry for the Inconvenience.</h2><p>The email alert system is under going maintenance.</p></div>");
            });
            return false;   

         }
    });

}); <!--- end doc ready --->

$('#x_search-form').submit(function(e){
  e.preventDefault();
});
