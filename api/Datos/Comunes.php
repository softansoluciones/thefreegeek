<?php

include_once 'MetodosDatos.php';

class DComunes {

    public function get_MesesSel() {
        $sql = "CALL Meses_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }
    
     public function get_YearsSel() {
        $sql = "CALL Years_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_SeccionesSel() {
        $sql = "CALL Secciones_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }
    
    public function get_TContenidoSel() {
        $sql = "CALL Tipoconenido_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_TUsuariosSel() {
        $sql = "CALL UsuariosTipo_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_TDocumentoSel() {
        $sql = "CALL TDocumento_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }
    
     public function get_CategoriasSel() {
        $sql = "CALL Categorias_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

}
