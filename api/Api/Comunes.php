<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Logica/Comunes.php');
include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Logica/Tokens.php');

$GLOBALS['token'] = new Tokens();
$GLOBALS['datos'] = new Comunes();
$GLOBALS['res'] = new \stdClass();

$url = $_SERVER['REQUEST_URI'];
$urlservicios = explode("Comunes.php/", $url);
//$accion = $urlservicios[0];
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
    }
}
$metodo = $_SERVER['REQUEST_METHOD'];
if(isset($_SERVER['HTTP_AUTHTOKEN'])){
    $GLOBALS['tokenhash'] = $_SERVER['HTTP_AUTHTOKEN'];
}else{
    $GLOBALS['tokenhash'] = "noauth";
}

switch ($metodo) {
    case 'GET':

        if ($accion != null) {
            if ($accion == "meses") {
                GetMeses();
            } elseif ($accion == "years") {
                GetYears();
            } elseif ($accion == "secciones") {
                GetSecciones();
            }elseif ($accion == "tcontenido") {
                GetTContenido();
            }elseif ($accion == "tusuarios") {
                GetTUsuarios();
            }elseif ($accion == "tdocumento") {
                GetTDocumento();
            }elseif ($accion == "concursos") {
                GetConcursos();
            } else {
                $GLOBALS['res']->Respuesta = 0;
                $GLOBALS['res']->Mensaje = "Acción no existe o no está soportada por el servicio";
                echo json_encode($GLOBALS['res']);
            }
        } else {

            $GLOBALS['res']->Respuesta = 0;
            $GLOBALS['res']->Mensaje = "Es necesario que agrege una acción.";
            echo json_encode($GLOBALS['res']);
        }
        break;

    case 'POST':

        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;

        break;

    case 'PUT':

        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;

        break;

    case 'DELETE':

        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;

        break;

    default:
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Método no soportado por el servicio";
        echo json_encode($GLOBALS['res']);
        break;
}

function GetMeses() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_MesesSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }
}

function GetYears() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_YearsSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }

}

function GetSecciones() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_SeccionesSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }

}

function GetTContenido() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_TContenidoSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }

}

function GetTUsuarios() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_TUsuariosSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }

}

function GetTDocumento() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_TDocumentoSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }

}

function GetConcursos() {

    $tokenres =  $GLOBALS['token']->get_TokenEstado($GLOBALS['tokenhash']);
    if($tokenres[0]['estado'] == 1){
        $resultado = $GLOBALS['datos']->get_ConcursosSel();

    if ($resultado != 0) {

        $GLOBALS['res']->Respuesta = $resultado;
        $GLOBALS['res']->Mensaje = "Información obtenida con éxito";
        echo json_encode($GLOBALS['res']);
    } else {
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "No existe información.";
        echo json_encode($GLOBALS['res']);
    }
    }else{
        $GLOBALS['res']->Respuesta = 0;
        $GLOBALS['res']->Mensaje = "Usuario no autorizado.";
        echo json_encode($GLOBALS['res']);
    }

}
