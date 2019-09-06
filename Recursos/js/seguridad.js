/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function verificacionI() {
  var login = sessionStorage.getItem("ses_estado");

  if (login != "thefreegeek") {
    sessionStorage.clear();
    window.location = 'index';
  }
}

function verificacionL() {
  var login = sessionStorage.getItem("ses_estado");

  if (login == "thefreegeek") {
    window.location = 'principal';
  } else {
    sessionStorage.clear();
  }
}

function LogOut() {
  sessionStorage.clear();
  window.location = 'index';
}

//-----------------------------------Token-------------------------------------//

function veificar_Token() {

  var token = sessionStorage.getItem('token');
  if (token == null) {
    Create_Token();
  }

}

function Create_Token() {

  var xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function () {
    if (this.readyState == 4 && this.status == 200) {
      var myObj = JSON.parse(this.responseText);
      var myObj2 = JSON.parse(myObj.Respuesta);
      document.getElementById("demo").innerHTML = myObj2;
    }
  };
  xmlhttp.open("GET", "http://localhost/thefreegeek/api/Api/Tokens.php/token/1065626260", true);
  xmlhttp.send();

  var user = sessionStorage.getItem('user');

  $.ajax({
    type: 'GET',
    url: 'api/Api/Tokens.php/token/' + user,
    dataType: 'json',
    success: function (response) {
      if (response.Respuesta != 0) {
        sessionStorage.setItem('token', response.Respuesta[0].token);
      } else {
        if (response.Mensaje = "Usuario no autorizado.") {
          window.location = '../FF2019/noauth.html';
        }
      }
    },
    beforeSend: function () {

    }
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $("#btns").html("<input data-dismiss='modal' aria-label='Close' class='btn btn_ch_normal m-r-1em' value='Aceptar'/>");
    $("#msg").html("<center><p>" + jqXHR + " " + textStatus + " " + errorThrown + "</center>");
    $('#modal_msg').modal({
      backdrop: 'static',
      keyboard: true,
      show: true
    });
  });
}
