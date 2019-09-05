<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/FF2019/api/Logica/Secciones.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/FF2019/api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Secciones();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Secciones.php/", $url);

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

switch ($metodo) {
    case 'GET':

        if (isset($accion)) {
            if ($accion == "lista") {
                GetSecciones();
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
            SaveSecciones();
        }else {
            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
            echo json_encode($GLOBALS['res']);
        }
    }else {
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
        DeleteSecciones($datosget);
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
        echo json_encode($GLOBALS['res']);
    }
    }else{
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

function GetSecciones() {

    $resultado = $GLOBALS['datos']->get_Secciones();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
}

function SaveSecciones() {
  
    $nombre = $_POST['nombre'];
    
    $resultado = $GLOBALS['datos']->save_Secciones($nombre);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información registrada con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Error al registrar información.";
        echo json_encode($GLOBALS['res']);
    }
}

function DeleteSecciones($id) {


    $resultado = $GLOBALS['datos']->delete_Secciones($id);

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información eliminada con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Error al eliminar información.";
        echo json_encode($GLOBALS['res']);
    }
}
