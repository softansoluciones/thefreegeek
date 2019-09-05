<?php

include_once 'MetodosDatos.php';

class DSecciones{

    public function get_Secciones() {
        $sql = "CALL Secciones_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function save_Secciones($nombre) {
        $sql = "CALL Secciones_Add('$nombre');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function delete_Secciones($id) {
        $sql = "CALL Secciones_Delete('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
