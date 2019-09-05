<?php

include_once 'MetodosDatos.php';

class DCms{

    public function get_Cms() {
        $sql = "CALL Cms_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_CmsXId($id) {
        $sql = "CALL Cms_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_CmsXTContenido($id) {
        $sql = "CALL Cms_GetXTContenido('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_CmsXSeccion($id) {
        $sql = "CALL Cms_GetXSeccion('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function save_Cms($titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado) {
        $sql = "CALL Cms_Add('$titulo', '$contenido', '$infoadicional', '$infoextra', '$path', '$fecha', '$tcontenido', '$seccion', '$jerarquia', '$estado');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Cms($id, $titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado) {
        $sql = "CALL Cms_Update('$id', $titulo', '$contenido', '$infoadicional', '$infoextra', '$path', '$fecha', '$tcontenido', '$seccion', '$jerarquia', '$estado');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function delete_Cms($id) {
        $sql = "CALL Cms_Delete('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
