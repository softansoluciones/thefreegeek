<?php

include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Datos/Comunes.php');

class Comunes {
    
     public function get_MesesSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_MesesSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
     public function get_YearsSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_YearsSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
     public function get_SeccionesSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_SeccionesSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function get_TContenidoSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_TContenidoSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_TUsuariosSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_TUsuariosSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_TDocumentoSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_TDocumentoSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function get_ConcursosSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_ConcursosSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
     public function get_CategoriasSel() {


        $datos = new DComunes();
        $rows = array();

        $result = $datos->get_CategoriasSel();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
}
