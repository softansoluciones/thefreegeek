/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function verificacionI() {
    var login = sessionStorage.getItem("ses_estado");

    if (login != "FrikiFestivalAdmin") {
      sessionStorage.clear();
        window.location = 'index';
    }else{
        $("body").show();
    }
}

function verificacionL() {
    var login = sessionStorage.getItem("ses_estado");

    if (login == "FrikiFestivalAdmin") {
        window.location = 'principal';
    }else {
      sessionStorage.clear();
    }
}

function LogOut() {
   sessionStorage.clear();
   window.location = 'index';
}

//-----------------------------------Token-------------------------------------//

function veificar_Token(){

    var token = sessionStorage.getItem('token');
    if(token == null){
        Create_Token();
    }

}

function Create_Token() {
    
    var user = sessionStorage.getItem('user');

    $.ajax({
      type: 'GET',
      url: 'api/Api/Tokens.php/token/'+user,
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
