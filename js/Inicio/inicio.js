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
                var contid = 0;
                datos.Respuesta.forEach(function (item) {
                    contid++;
                    html.innerHTML += '<div class="row"' + (contid % 2 == 0 ? 'style="border-top: #2d51a3 2px solid; border-right: #2d51a3 2px solid; margin: 2%;"' : 'style="border-top: #2d51a3 2px solid; border-left: #2d51a3 2px solid; margin: 2%;"') + '>\n\
                    <div class="col" style="">\n\
                    <img src="media/Noticias/' + item.path_cms + '" class="d-block w-100" alt="...">\n\
                    </div>\n\
                    <div class="col-9" style="">\n\
                    <br><br>\n\
                    <a href="' + item.infoextra_cms + '" style="color: black;"><h3>' + item.titulo_cms + '</h3></a>\n\
                    <hr>\n\
                    <p style="font-size: 130%;">' + item.contenido_cms + '</p>\n\
                    <p class="card-text"><small class="text-muted">' + item.fecha_cms + '</small></p>\n\
                    </div>\n\
                    </div>';
                })
            } else {
                if (datos.Mensaje == "Usuario no autorizado.") {
                    window.location = '../thefreegeek/noauth.html';
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

window.onload = function () {
    veificar_TokenIni()
};