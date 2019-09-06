var Globalmodulo = sessionStorage.getItem("modulo");
var GlobalUserid = parseInt(sessionStorage.getItem("id_user"));
var GlobalUserTipo = parseInt(sessionStorage.getItem("tipo_user"));
var GlobalUserNom = sessionStorage.getItem("nom_user");

function user_data() {
    document.getElementById("nom_us").innerHTML=sessionStorage.getItem("nom_user")
}

function get_modulo() {
    //verificacionI();
    var modulo = sessionStorage.getItem("modulo");

    switch (modulo) {
        case "1":
            Vista_Contenidos()
            break;
        case "1.1":
            Vista_ContenidosReg()
            break;
        case "2":
            Vista_Cheilers()
            break;
        case "2.1":
            Vista_CheilersReg()
            break;
        case "3":
            Vista_Novedades()
            break;
        case "3.1":
            Vista_NovedadesReg()
            break;
        case "4":
            Vista_Usuarios()
            break;
        case "5":
            Vista_UsuarioInfo()
            break;
        default:
            Vista_Reportes()
    }

}

function Vista_Contenidos() {
    user_data();
    //load_contenido('contenidoLista')
    //var activo1 = document.getElementsByClassName('active_nav');
	//Array.prototype.forEach.call(activo1, function(item) {
    //    item.classList.add("is-invalid");
    //    })
    sessionStorage.setItem("modulo", 1);
    removeActive();
    hideSubmenu();
    $('#mod_1').addClass('active_nav');
    $('#mod_1_1').addClass('active_nav');
    $('#subMod_1').show('fast');
}

function Vista_ReportesMes() {

    $("#L_contenido").load("reportesMes.html");
    sessionStorage.setItem("modulo", 1.1);
    removeActive();
    hideSubmenu();
    $('#mod_1').addClass('active_nav');
    $('#mod_1_2').addClass('active_nav');
    $('#subMod_1').show('fast');
}

function Vista_Cheilers() {
    $("#L_contenido").load("cheilers.html");
    $('#modal_msg').modal('hide')
    sessionStorage.setItem("modulo", 2);
    removeActive();
    hideSubmenu();
    $('#mod_2').addClass('active_nav');
    $('#mod_2_1').addClass('active_nav');
    $('#subMod_2').show('fast');
}

function Vista_CheilersReg() {
    $("#L_contenido").load("cheilersReg.html");
    $('#modal_msg').modal('hide')
    sessionStorage.setItem("modulo", 2.1);
    removeActive();
    hideSubmenu();
    $('#mod_2').addClass('active_nav');
    $('#mod_2_2').addClass('active_nav');
    $('#subMod_2').show('fast');
}

function Vista_Novedades() {
    user_data();
    $("#L_contenido").load("novedades.html");
    $("#C_Contenido").load("novedades.html");
    $('#modal_msg').modal('hide')
    sessionStorage.setItem("modulo", 3);
    removeActive();
    hideSubmenu();
    $('#mod_3').addClass('active_nav');
    $('#mod_3_1').addClass('active_nav');
    $('#subMod_3').show('fast');
}

function Vista_NovedadesReg() {
    user_data();
    $("#L_contenido").load("novedadesReg.html");
    $("#C_Contenido").load("novedadesReg.html");
    $('#modal_msg').modal('hide')
    sessionStorage.setItem("modulo", 3.1);
    removeActive();
    hideSubmenu();
    $('#mod_3').addClass('active_nav');
    $('#mod_3_2').addClass('active_nav');
    $('#subMod_3').show('fast');
}

function Vista_Usuarios() {
    $("#L_contenido").load("usuarios.html");
    sessionStorage.setItem("modulo", 4);
    removeActive();
    hideSubmenu();
    $('#mod_4').addClass('active_nav');
}

function Vista_UsuarioInfo() {
    $("#L_contenido").load("usuariosinfo.html");
    $("#C_Contenido").load("usuariosinfo.html");
    sessionStorage.setItem("modulo", 5);
    removeActive();
    hideSubmenu();
    $('#mod_5').addClass('active_nav2');
}

function ActualizarPagina() {
    location.reload(true);
}

function removeActive() {

    $(".active_nav").each(function () {
        $(this).removeClass("active_nav");
    });

    $(".active_nav2").each(function () {
        $(this).removeClass("active_nav2");
    });

}

function hideSubmenu() {
    $("div[name ='sub_menu']").each(function () {
        $(this).hide("fast");
    });

}

function menuPan() {

    //alert($("#menupan").position().left);
    //alert($(window).width());

    var panpos = $(window).width();
    if ($("#menupan").position().left >= panpos) {
        $("#menupan").animate({ left: '0%' });
        $("body").addClass('overbody');
    } else {
        $("#menupan").animate({ left: '100%' });
        $("body").removeClass('overbody');

    }

}

async function load_panel() {
    let url = 'Recursos/navbarPanel.html'
  
    document.getElementById("navb_1").innerHTML= await (await fetch(url)).text();
    get_modulo();
}

async function load_contenido(contenido) {
    let url = contenido+'.html'
  
    document.getElementById("L_contenido").innerHTML= await (await fetch(url)).text();
    get_modulo();
}


  window.onload = function() {
    //verificacionI();  
    load_panel()
  };
