$(document).ready(function(){
  //global vars
  var userName = $("#user"); //user name field
  var userPass = $("#pass"); //password field


  //function to check name and comment field
  function checkCommentsForm(){
    if(userName.attr("value") && userPass.attr("value"))
      return true;
    else
      return false;
  }

  //When form submitted
  $("#formL").submit(function(){
    if(checkCommentsForm()){
      $.ajax({
        type: "post"
       , url: "loginvalidate.jsp"
       ,data: "user="+userName.val()+"&pass="+userPass.val(),
       success: function(msg) {$('#targetDiv').hide();$("#targetDiv").html ("<h3>" + msg + "</h3>").fadeIn("slow");}
        });
        }
    else alert("Please fill UserName & Password!");
    return false;
  });
});

