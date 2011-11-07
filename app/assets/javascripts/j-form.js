$(document).ready(function(){
  $('.j-form select').selectBox();
  $('.j-form form').validate({
    errorPlacement: function(error,element) {
      error.appendTo( element.parent() );
    },
    errorElement: "span",
    errorClass: "err_field"
  });
});
