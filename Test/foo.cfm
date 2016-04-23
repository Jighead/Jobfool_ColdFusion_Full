<cfparam name="noreturn" default="false">
<cfparam name="url.kw" default="">
<cfset intStartTime = GetTickCount() />
<cfparam name="url.l" default="">
<cfparam name="url.co" default="US">
<cfparam name="url.sb" default="">
<cfparam name="url.radius" default="50">
<cfparam name="request.grecords" default="0">
<cfparam name="url.qt" default="10"><!--- qty per page --->
<cfparam name="url.p" default="1"><!--- default page were on --->
<cfparam name="url.st" default="1"><!--- default start row were on --->
<cfparam name="url.from" default="90"><!--- default start row were on --->
<cfset url.fromage = url.from>
<cfparam name="request.intotalrecords" default="">
<cfset foo = randrange(1, 10)>

    
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
<script type="text/javascript" src="assets/plugins/jquery/jquery-migrate.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.js"></script>

<form id="alert">
    <label>What</label><input type="text" name="kw" value="" id="kw" min-length="3" required>
    <label>Where</label><input type="text" name="loc" value="" id="loc" min-length="3" required>
    <label>Where</label><input type="email" name="email" value="job@gmail" id="email">
    <button id="alertbtn" class="btn" type="submit">
     <i class="fa fa-envelope-o">go</i>
    </button>
</form>
<script>
$(document).ready(function($){


 
$("#contactform").validate({
         ignore: ":hidden",
         rules: {
             kw: {
                 required: true,
                 minlength: 3
             },
             loc: {
                 required: true
                 minlength: 3
             },
             email: {
                 required: true,
                 message: "Please enter a valid email address."
             }
         },
         submitHandler: function (form) {

                 $.ajax({
                    type: "POST",
                    dataType:"json",
                    url: "/controller/addalert.cfm",
                    data: $(this).serialize()
                }).done(function(){
                    $('#emailform').html(
                        "<div class='col-xs-12'><h2>Sweet! You're almost Done.</h2><p>To activate your job alert, please check your email and click the confirmation link.</p></div>");
                }).fail(function(){
                          $('#emailform').html(
                        "<div class='col-xs-12'><h2>Sorry for the Inconvenience.</h2><p>The email alert sytems in under going maintenance.</p></div>");
                });
                return false;   

             }
        });

    
 });
</script>
