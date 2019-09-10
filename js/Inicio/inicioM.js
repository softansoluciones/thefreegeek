function veificar_TokenIni() {

    var token = sessionStorage.getItem('token');
    if (token == null) {
        Create_TokenIni();
    } else {
        Cargar_Noticias();
    }

}

function Create_TokenIni() {

    var user = sessionStorage.getItem('user');

    var data = null;

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                sessionStorage.setItem('token', datos.Respuesta[0].token);
                Cargar_Banners();
            } else {
                if (response.Mensaje = "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                }
            }
        }
    });

    xhr.open("GET", 'api/Api/Tokens.php/token/' + user);
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.send(data);
}

function Cargar_Banners() {

    var token = sessionStorage.getItem('token');
    var data = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                var html = document.getElementById('bann_contenido');
                html.innerHTML = '';
                var htmlind = document.getElementById('bann_contenido');
                htmlind.innerHTML = '';
                var contid = 0;
                datos.Respuesta.forEach(function (item) {
                    html.innerHTML += '<div' + (contid == 0 ? 'class="carousel-item active"' : 'class="carousel-item"') + '>\n\
                    <img src="media/Banners/' + item.path + '" class="d-block w-100" alt="...">\n\
                    </div>';
                    htmlind.innerHTML += '<li data-target="#carouselExampleIndicators" data-slide-to="' + contid + '" ' + (contid == 0 ? 'class="active"' : 'class=""') + '></li>';
                    contid++;
                })
                Cargar_Noticias();
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                } else {
                    var html = document.getElementById('bann_contenido');
                    html.innerHTML = '<center>'+datos.Mensaje+'</center>';
                }
                Cargar_Noticias();
            }
        }
    });

    xhr.open("GET", 'api/Api/Cms.php/contenido/2');
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.setRequestHeader("authtoken", token);
    xhr.setRequestHeader("cache-control", "no-cache");

    xhr.send(data);
}

function Cargar_Noticias() {

    document.getElementById('ini_noticias_det').innerHTML = '<div class="d-flex justify-content-center">\n\
    <div class="spinner-border" role="status">\n\
      <span class="sr-only">Loading...</span>\n\
    </div>\n\
    </div>'
    var token = sessionStorage.getItem('token');
    var data = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                var html = document.getElementById('ini_noticias_det');
                html.innerHTML = '';
                var htmlpag = document.getElementById('ini_noticias_pag');
                htmlpag.innerHTML = '';
                var contid = 0;
                datos.Respuesta.forEach(function (item) {
                    contid++;
                    html.innerHTML += '<div class=""' + (contid % 2 == 0 ? 'style="border-top: #2d51a3 2px solid; border-right: #2d51a3 2px solid; margin: 2%;"' : 'style="border-top: #2d51a3 2px solid; border-left: #2d51a3 2px solid; margin: 2%;"') + '>\n\
                    <div class="col" style="">\n\
                    <img src="media/Noticias/' + item.path_cms + '" class="d-block w-100" alt="...">\n\
                    </div>\n\
                    <div class="col" style="">\n\
                    <br><br>\n\
                    <a href="' + item.infoextra_cms + '" style="color: black;"><h3>' + item.titulo_cms + '</h3></a>\n\
                    <hr>\n\
                    <p style="font-size: 130%;">' + item.contenido_cms + '</p>\n\
                    <p class="card-text"><small class="text-muted">' + item.fecha_cms + '</small></p>\n\
                    </div>\n\
                    </div>';
                })

                var pag = datos.Respuesta[0].paginas;
                for (var i = 1; i <= pag; i++) {
                    htmlpag.innerHTML += '<li class="page-item"><a class="page-link" href="javascript: Cargar_NoticiasXPag(' + i + ')">' + i + '</a></li>';
                }
                Cargar_Categorias();
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                }else {
                    var html = document.getElementById('ini_noticias_det');
                    html.innerHTML = '<center>'+datos.Mensaje+'</center>';
                }
            }
        }
    });

    xhr.open("GET", 'api/Api/Cms.php/noticias');
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.setRequestHeader("authtoken", token);
    xhr.setRequestHeader("cache-control", "no-cache");

    xhr.send(data);
}

function Cargar_Categorias() {

    var token = sessionStorage.getItem('token');
    var data = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                var panel = document.getElementById('menupan_items');
                panel.innerHTML = '';
                datos.Respuesta.forEach(function (item) {
                    panel.innerHTML += '<a class="anav nav-item nav-link" name="menup" href="javascript: Cargar_NoticiasXCategoria(' + item.id + '), menuPan()">' + item.nom + '</a>';
                })
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                }else {
                    var html = document.getElementById('menupan_items');
                    html.innerHTML = '<center>'+datos.Mensaje+'</center>';
                }
            }
        }
    });

    xhr.open("GET", 'api/Api/Comunes.php/categorias');
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.setRequestHeader("authtoken", token);
    xhr.setRequestHeader("cache-control", "no-cache");

    xhr.send(data);
}

function Cargar_NoticiasXPag(pag) {

    document.getElementById('ini_noticias_det').innerHTML = '<div class="d-flex justify-content-center">\n\
    <div class="spinner-border" role="status">\n\
      <span class="sr-only">Loading...</span>\n\
    </div>\n\
    </div>'
    var token = sessionStorage.getItem('token');
    var data = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                var html = document.getElementById('ini_noticias_det');
                $('#ini_noticias_det').html('')
                var htmlpag = document.getElementById('ini_paginas');
                $('#ini_paginas').html('')
                var contid = 0;
                datos.Respuesta.forEach(function (item) {
                    contid++;
                    html.innerHTML += '<div class=""' + (contid % 2 == 0 ? 'style="border-top: #2d51a3 2px solid; border-right: #2d51a3 2px solid; margin: 2%;"' : 'style="border-top: #2d51a3 2px solid; border-left: #2d51a3 2px solid; margin: 2%;"') + '>\n\
                    <div class="col" style="">\n\
                    <img src="media/Noticias/' + item.path_cms + '" class="d-block w-100" alt="...">\n\
                    </div>\n\
                    <div class="col" style="">\n\
                    <br><br>\n\
                    <a href="' + item.infoextra_cms + '" style="color: black;"><h3>' + item.titulo_cms + '</h3></a>\n\
                    <hr>\n\
                    <p style="font-size: 130%;">' + item.contenido_cms + '</p>\n\
                    <p class="card-text"><small class="text-muted">' + item.fecha_cms + '</small></p>\n\
                    </div>\n\
                    </div>';
                })
                var pag = datos.Respuesta[0].paginas;

                for (var i = 1; i < pag; i++) {
                    htmlpag.innerHTML += '<li class="page-item"><a class="page-link" href="javascript: Cargar_NoticiasXPag(' + i + ')">' + i + '</a></li>';
                }
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                }else {
                    var html = document.getElementById('ini_noticias_det');
                    html.innerHTML = '<center>'+datos.Mensaje+'</center>';
                }
            }
        }
    });

    xhr.open("GET", 'api/Api/Cms.php/pagina/1/' + pag);
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.setRequestHeader("authtoken", token);
    xhr.setRequestHeader("cache-control", "no-cache");

    xhr.send(data);
}

function Cargar_NoticiasXCategoria(cat) {
    document.getElementById('ini_noticias_det').innerHTML = '<div class="d-flex justify-content-center">\n\
    <div class="spinner-border" role="status">\n\
      <span class="sr-only">Loading...</span>\n\
    </div>\n\
    </div>'
    var token = sessionStorage.getItem('token');
    var data = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                var html = document.getElementById('ini_noticias_det');
                $('#ini_noticias_det').html('')
                var htmlpag = document.getElementById('ini_paginas');
                $('#ini_paginas').html('')
                var contid = 0;
                datos.Respuesta.forEach(function (item) {
                    contid++;
                    html.innerHTML += '<div class=""' + (contid % 2 == 0 ? 'style="border-top: #2d51a3 2px solid; border-right: #2d51a3 2px solid; margin: 2%;"' : 'style="border-top: #2d51a3 2px solid; border-left: #2d51a3 2px solid; margin: 2%;"') + '>\n\
                    <div class="col" style="">\n\
                    <img src="media/Noticias/' + item.path_cms + '" class="d-block w-100" alt="...">\n\
                    </div>\n\
                    <div class="col" style="">\n\
                    <br><br>\n\
                    <a href="' + item.infoextra_cms + '" style="color: black;"><h3>' + item.titulo_cms + '</h3></a>\n\
                    <hr>\n\
                    <p style="font-size: 130%;">' + item.contenido_cms + '</p>\n\
                    <p class="card-text"><small class="text-muted">' + item.fecha_cms + '</small></p>\n\
                    </div>\n\
                    </div>';
                })
                var pag = datos.Respuesta[0].paginas;

                for (var i = 1; i < pag; i++) {
                    htmlpag.innerHTML += '<li class="page-item"><a class="page-link" href="javascript: Cargar_NoticiasXCatXPag(' + cat + ' , ' + i + ')">' + i + '</a></li>';
                }
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                }else {
                    var html = document.getElementById('ini_noticias_det');
                    html.innerHTML = '<center>'+datos.Mensaje+'</center>';
                }
            }
        }
    });

    xhr.open("GET", 'api/Api/Cms.php/categoria/' + cat);
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.setRequestHeader("authtoken", token);
    xhr.setRequestHeader("cache-control", "no-cache");

    xhr.send(data);
}

function Cargar_NoticiasXCatXPag(cat, pag) {

    document.getElementById('ini_noticias_det').innerHTML = '<div class="d-flex justify-content-center">\n\
    <div class="spinner-border" role="status">\n\
      <span class="sr-only">Loading...</span>\n\
    </div>\n\
    </div>'
    var token = sessionStorage.getItem('token');
    var data = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            var datos = JSON.parse(this.responseText)
            if (datos.Respuesta != 0) {
                var html = document.getElementById('ini_noticias_det');
                $('#ini_noticias_det').html('')
                var htmlpag = document.getElementById('ini_paginas');
                $('#ini_paginas').html('')
                var contid = 0;
                datos.Respuesta.forEach(function (item) {
                    contid++;
                    html.innerHTML += '<div class=""' + (contid % 2 == 0 ? 'style="border-top: #2d51a3 2px solid; border-right: #2d51a3 2px solid; margin: 2%;"' : 'style="border-top: #2d51a3 2px solid; border-left: #2d51a3 2px solid; margin: 2%;"') + '>\n\
                    <div class="col" style="">\n\
                    <img src="media/Noticias/' + item.path_cms + '" class="d-block w-100" alt="...">\n\
                    </div>\n\
                    <div class="col" style="">\n\
                    <br><br>\n\
                    <a href="' + item.infoextra_cms + '" style="color: black;"><h3>' + item.titulo_cms + '</h3></a>\n\
                    <hr>\n\
                    <p style="font-size: 130%;">' + item.contenido_cms + '</p>\n\
                    <p class="card-text"><small class="text-muted">' + item.fecha_cms + '</small></p>\n\
                    </div>\n\
                    </div>';
                })
                var pag = datos.Respuesta[0].paginas;

                for (var i = 1; i < pag; i++) {
                    htmlpag.innerHTML += '<li class="page-item"><a class="page-link" href="javascript: Cargar_NoticiasXCatXPag(' + cat + ' , ' + i + ')">' + i + '</a></li>';
                }
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
                }else {
                    var html = document.getElementById('ini_noticias_det');
                    html.innerHTML = '<center>'+datos.Mensaje+'</center>';
                }
            }
        }
    });

    xhr.open("GET", 'api/Api/Cms.php/categoriapag/' + cat + '/' + pag);
    xhr.setRequestHeader("Accept", "*/*");
    xhr.setRequestHeader("Cache-Control", "no-cache");
    xhr.setRequestHeader("authtoken", token);
    xhr.setRequestHeader("cache-control", "no-cache");

    xhr.send(data);

}

window.onload = function () {
    veificar_TokenIni()
};