var fecha = new Date();
var anio = fecha.getYear() - 100;
var mes = fecha.getMonth() + 1;
var dia = fecha.getDate();
var base = 'http://localhost/';
var baseRem = '';
var Gustoken = sessionStorage.getItem('token')

function buscarData(tabla) {
    var tableReg = document.getElementById(tabla);
    var searchText = document.getElementById('filtrar').value.toLowerCase();
    var cellsOfRow = "";
    var found = false;
    var compareWith = "";

    // Recorremos todas las filas con contenido de la tabla
    for (var i = 1; i < tableReg.rows.length; i++) {
        cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
        found = false;
        // Recorremos todas las celdas
        for (var j = 0; j < cellsOfRow.length && !found; j++) {
            compareWith = cellsOfRow[j].innerHTML.toLowerCase();
            // Buscamos el texto en el contenido de la celda
            if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1)) {
                found = true;
            }
        }
        if (found) {
            tableReg.rows[i].style.display = '';
        } else {
            // si no ha encontrado ninguna coincidencia, esconde la
            // fila de la tabla
            tableReg.rows[i].style.display = 'none';
        }
    }
}

function countCampos(name) {
    var cantidad = document.getElementsByName(name);

    return cantidad.length;
}

function ValidarCampos(name) {

    var tot = countCampos(name);
    var campos = document.getElementsByName(name);
    var cont = 0;
    var msg;

    campos.forEach(function (item) {
        if (item.value.length == 0) {
            var camp = item.dataset.campo;
            msg = '<p>Es necesario que llene el campo ' + camp + '</p>';
            item.classList.add("is-invalid");
            item.focus();
            return false;
        }
        cont++;
    })

    if (cont == tot) {
        return true;
    } else {
        return msg;
    }

}

function removec(d) {

    document.getElementsByClassName('alert').style.display = "none";
    d.classList.remove("is-invalid");
}

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
}

function menuPan() {

    //alert($("#menupan").position().left);
    //alert($(window).width());

    var panpos = screen.width;
    if ($("#menupan").position().left >= panpos) {
        $("#menupan").animate({
            left: '0%'
        });
        $("body").addClass('overbody');
    } else {
        $("#menupan").animate({
            left: '100%'
        });
        $("body").removeClass('overbody');

    }

}

function pc() {

    var device = navigator.userAgent

    if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) { } else {
        window.location = '../thefreegeek/inicio.html';
    }

}

function movil() {

    var device = navigator.userAgent

    if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {
        window.location = '../thefreegeek/inicioM.html';
    }
}

function redireccionLogin() {

    var device = navigator.userAgent

    if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {
        window.location = '../thefreegeek/loginM.html';
    } else {
        window.location = '../thefreegeek/login.html';
    }

}

function redireccionInicio() {

    var device = navigator.userAgent

    if (device.match(/Iphone/i) || device.match(/Ipod/i) || device.match(/Android/i) || device.match(/J2ME/i) || device.match(/BlackBerry/i) || device.match(/iPhone|iPad|iPod/i) || device.match(/Opera Mini/i) || device.match(/IEMobile/i) || device.match(/Mobile/i) || device.match(/Windows Phone/i) || device.match(/windows mobile/i) || device.match(/windows ce/i) || device.match(/webOS/i) || device.match(/palm/i) || device.match(/bada/i) || device.match(/series60/i) || device.match(/nokia/i) || device.match(/symbian/i) || device.match(/HTC/i)) {
        window.location = '../thefreegeek/inicioM.html';
    } else {
        window.location = '../thefreegeek/inicio.html';
    }

}

function inputfechaDate(input) {

    var valinput = input.value;

    if (valinput.length < 1) {
        input.type = "date";
    }
}

function inputfechaText(input) {

    var valinput = input.value;

    if (valinput.length < 1) {
        input.type = "text";
    }
}