<?php

include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Datos/Secciones.php');

class Cms {

    public function get_Secciones() {

        $datos = new DSecciones();
        $rows = array();

        $result = $datos->get_Secciones();
        
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function save_Secciones($nombre){
        
        $datos = new DSecciones();

        $result = $datos->save_Secciones($nombre);
        
        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
        
    }
    
    public function delete_Secciones($id){
        
        $datos = new DSecciones();
        
        $result = $datos->delete_Secciones($id);
        
         if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
        
    }

}
