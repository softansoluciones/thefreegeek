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

  var user = sessionStorage.getItem('user');

  var data = null;

  var xhr = new XMLHttpRequest();
  xhr.withCredentials = true;

  xhr.addEventListener("readystatechange", function () {
    if (this.readyState === 4) {
      var datos = JSON.parse(this.responseText)
      if (datos.Respuesta != 0) {
        sessionStorage.setItem('token', datos.Respuesta[0].token)
      }else{
        if (response.Mensaje = "Usuario no autorizado.") {
          window.location = '../thefreegeek/noauth.html';
        }
      }
    }
  });

  xhr.open("GET", 'api/Api/Tokens.php/token/' + user);
  xhr.setRequestHeader("Accept", "*/*");
  xhr.setRequestHeader("Cache-Control", "no-cache");
  //xhr.setRequestHeader("Postman-Token", "c633361b-7357-4c73-93f9-7ab8aae439fe,66bd0753-a19b-495e-9091-d9a95de24cf2");
  xhr.setRequestHeader("cache-control", "no-cache");

  xhr.send(data);
}