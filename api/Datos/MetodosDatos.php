<?php

date_default_timezone_set('America/Bogota');

include_once 'Configuracion.php';

class dbmanager {

    public function executeQuery($sql) {

        //$conf = new strConfiguration();

        $con = mysqli_connect(configur::getserver(), configur::getuser(), configur::getpass(), configur::getbd());
        //$string = $conf->strconnection();
        //$con = mysqli_connect($string);
        //echo '<pre>';
        //print_r($con);
        //exit();

        $acentos = $con->query("SET NAMES 'utf8'");

        if (!$acentos) {

            die('No Se Pudo Conectar: ' . mysqli_connect_error());
        }


        $result = $con->query($sql);

        mysqli_close($con);
        return $result;
    }

}