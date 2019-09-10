<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Logica/Cms.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Cms();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Cms.php/", $url);

if (count($urlservicios) > 1) {
    $urlserviciosdes = explode("?", $urlservicios[1]);
    $urlserviciosget = explode("/", $urlservicios[1]);
    if (count($urlserviciosdes) > 1) {
        $accion = $urlserviciosdes[0];
    } else {
        $accion = $urlserviciosget[0];
    }
    if (count($urlserviciosget) > 1) {
        $datosget = $urlserviciosget[1];
        if (count($urlserviciosget) > 2) {
            $datosget2 = $urlserviciosget[2];
        }
    }
}

$metodo = $_SERVER['REQUEST_METHOD'];
if (isset($_SERVER['HTTP_AUTHTOKEN'])) {
    $GLOBALS['tokenhash'] = $_SERVER['HTTP_AUTHTOKEN'];
} else {
    $GLOBALS['tokenhash'] = "noauth";
}

switch ($metodo) {
    case 'GET':

        if (isset($accion)) {
            if ($accion == "lista") {
                GetCms();
            } elseif ($accion == "id") {
                GetCmsXId($datosget);
            } elseif ($accion == "contenido") {
                GetCmsXContenido($datosget);
            } elseif ($accion == "seccion") {
                GetCmsXSeccion($datosget);
            } elseif ($accion == "categoria") {
                GetCmsXCategoria($datosget);
            }elseif ($accion == "pagina") {
                GetCmsXPagina($datosget, $datosget2);
            }elseif ($accion == "noticias") {
                GetCmsXNoticias();
            } else {
                $GLOBALS['res']->Respuesta = 0;
                $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
                echo json_encode($GLOBALS['res']);
            }
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No se ha detectado acción";
            echo json_encode($GLOBALS['res']);
        }
        break;

    case 'POST':

        if (isset($accion)) {
            if ($accion == "guardar") {
                SaveCms();
            } elseif ($accion == "actualizar") {
                UpdateCms();
            } else {
                $GLOBALS['res']->Respuesta = 0;
                $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
                echo json_encode($GLOBALS['res']);
            }
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No se ha detectado acción";
            echo json_encode($GLOBALS['res']);
        }
        break;

    case 'PUT':

        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);

        break;

    case 'DELETE':
        if (isset($accion)) {
            if ($accion == "eliminar") {
                DeleteCms($datosget);
            } else {
                $GLOBALS['res']->Respuesta = 0;
                $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
                echo json_encode($GLOBALS['res']);
            }
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No se ha detectado acción";
            echo json_encode($GLOBALS['res']);
        }
        break;

    default:
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;
}

function GetCms() {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_Cms();

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetCmsXId($id) {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_CmsXId($id);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetCmsXContenido($id) {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_CmsXTContenido($id);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetCmsXSeccion($id) {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_CmsXSeccion($id);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetCmsXCategoria($id) {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_CmsXCategoria($id);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetCmsXPagina($id, $pag) {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_CmsXPagina($id, $pag);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetCmsXNoticias() {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->get_CmsXNoticias();

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "No existe información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function SaveCms() {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {

        $titulo = $_POST['titulo'];
        $contenido = $_POST['contenido'];
        $infoadicional = $_POST['infoadicional'];
        $infoextra = $_POST['infoextra'];
        $path = $_POST['path'];
        $fecha = $_POST['fecha'];
        $tcontenido = $_POST['tcontenido'];
        $seccion = $_POST['seccion'];
        $jerarquia = $_POST['jerarquia'];
        $estado = $_POST['estado'];
        $ambiente = $_POST['ambiente'];
        $categoria = $_POST['categoria'];
        if (isset($_FILES['archivo'])) {
            $archivo = $_FILES['archivo'];
        } else {
            $archivo = 0;
        }

        $resultado = $GLOBALS['datos']->save_Cms($titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado, $ambiente, $categoria, $archivo);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información registrada con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Error al registrar información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function UpdateCms() {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $id = $_POST['id'];
        $titulo = $_POST['titulo'];
        $contenido = $_POST['contenido'];
        $infoadicional = $_POST['infoadicional'];
        $infoextra = $_POST['infoextra'];
        $path = $_POST['path'];
        $fecha = $_POST['fecha'];
        $tcontenido = $_POST['tcontenido'];
        $seccion = $_POST['seccion'];
        $jerarquia = $_POST['jerarquia'];
        $estado = $_POST['estado'];
        $ambiente = $_POST['ambiente'];
        $categoria = $_POST['categoria'];
        if (isset($_FILES['archivo'])) {
            $archivo = $_FILES['archivo'];
        } else {
            $archivo = 0;
        }

        $resultado = $GLOBALS['datos']->update_Cms($id, $titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado, $ambiente, $categoria, $archivo);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información registrada con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Error al registrar información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function DeleteCms($id) {

    $tokenres = $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if ($tokenres[0]['estado'] == 1) {
        $resultado = $GLOBALS['datos']->delete_Cms($id);

        if ($resultado != 0) {

            $GLOBALS['res']->Respuesta = $resultado;
            $GLOBALS['res']->Mensaje = "Información eliminada con éxito";
            echo json_encode($GLOBALS['res']);
        } else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Error al eliminar información.";
            echo json_encode($GLOBALS['res']);
        }
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}
