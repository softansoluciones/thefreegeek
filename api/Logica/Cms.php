<?php

include_once($_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/api/Datos/Cms.php');

class Cms {

    public function get_Cms() {

        $datos = new DCms();
        $rows = array();

        $result = $datos->get_Cms();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CmsXId($id) {

        $datos = new DCms();
        $rows = array();

        $result = $datos->get_CmsXId($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CmsXTContenido($id) {

        $datos = new DCms();
        $rows = array();

        $result = $datos->get_CmsXTContenido($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CmsXNoticias() {

        $datos = new DCms();
        $rows = array();
        $cont = 1;

        $result = $datos->get_CmsXTContenido('1');

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $row['paginas'] = (is_float($result->num_rows / 10) == true) ? ceil($result->num_rows / 10) : ($result->num_rows / 10);
                ;
                $row['pagina'] = (is_float($cont / 10) == true) ? ceil($cont / 10) : ($cont / 10);
                if ($row['pagina'] == 1) {
                    $rows[] = $row;
                }
                $cont++;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CmsXPagina($id, $pag) {

        $datos = new DCms();
        $rows = array();
        $cont = 1;

        $result = $datos->get_CmsXTContenido($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $row['paginas'] = (is_float($result->num_rows / 10) == true) ? ceil($result->num_rows / 10) : ($result->num_rows / 10);
                ;
                $row['pagina'] = (is_float($cont / 10) == true) ? ceil($cont / 10) : ($cont / 10);
                if ($row['pagina'] == $pag) {
                    $rows[] = $row;
                }
                $cont++;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CmsXSeccion($id) {

        $datos = new DCms();
        $rows = array();

        $result = $datos->get_CmsXSeccion($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CmsXCategoria($id) {

        $datos = new DCms();
        $rows = array();
        $cont = 1;

        $result = $datos->get_CmsXCategoria($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $row['paginas'] = (is_float($result->num_rows / 10) == true) ? ceil($result->num_rows / 10) : ($result->num_rows / 10);
                $row['pagina'] = (is_float($cont / 10) == true) ? ceil($cont / 10) : ($cont / 10);
                if ($row['pagina'] == 1) {
                    $rows[] = $row;
                }
                $cont++;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function get_CmsXCategoriaXPag($id, $pag) {

        $datos = new DCms();
        $rows = array();
        $cont = 1;

        $result = $datos->get_CmsXCategoria($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $row['paginas'] = (is_float($result->num_rows / 10) == true) ? ceil($result->num_rows / 10) : ($result->num_rows / 10);
                $row['pagina'] = (is_float($cont / 10) == true) ? ceil($cont / 10) : ($cont / 10);
                if ($row['pagina'] == $pag) {
                    $rows[] = $row;
                }
                $cont++;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function save_File($file, $tcontenido, $seccion) {

        $info = pathinfo($file['name']);
        $ext = $info['extension']; // get the extension of the file
        $newname = date("Y") . "_" . date("m") . "_" . date("d") . "_" . date("h_i_s") . "_" . $tcontenido . "_" . $seccion . "." . $ext;

        $target = $_SERVER['DOCUMENT_ROOT'] . '/thefreegeek/media/' . $newname;
        move_uploaded_file($file['tmp_name'], $target);
        return $newname;
    }

    public function save_Cms($titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado, $ambiente, $categoria, $archivo) {

        $datos = new DCms();
        $rows = array();

        if ($archivo == 0) {
            $file = $path;
        } else {
            $file = $this->save_File($archivo, $tcontenido, $seccion);
        }

        $result = $datos->save_Cms($titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado, $ambiente, $categoria);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Cms($id, $titulo, $contenido, $infoadicional, $infoextra, $path, $fecha, $tcontenido, $seccion, $jerarquia, $estado, $ambiente, $categoria, $archivo) {

        $datos = new DCms();

        if ($archivo == 0) {
            $file = $path;
        } else {
            $file = $this->save_File($archivo, $tcontenido, $seccion);
        }

        $result = $datos->update_Cms($id, $titulo, $contenido, $infoadicional, $infoextra, $file, $fecha, $tcontenido, $seccion, $jerarquia, $estado, $ambiente, $categoria);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Cms($id) {

        $datos = new DCms();

        $result = $datos->delete_Cms($id);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
