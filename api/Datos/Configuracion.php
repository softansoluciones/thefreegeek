<?php

class strConfiguration {

    public function strconnection() {

        $server = 'localhost';
        $user = 'root';
        $pass = 'root';
        $db = 'bdadmin';

        $str = $server . ', ' . $user . ', ' . $pass . ', ' . $db;

        return $str;
    }

}

class configur {

    public static function getserver() {
        return 'sql200.main-hosting.eu';
//return 'localhost';
        //return 'localhost:3306';
    }

    public static function getuser() {
        return 'u373472706_ff';
        //return 'u373472706_ffp';
//        return 'root';
        //return 'admin';
    }

    public static function getpass() {

        return 'Usuario01';
        //return 'root';
        //return 'admin';
    }

    public static function getbd() {

        return 'u373472706_ffdev';
        //return 'u373472706_ffpro';
        //return 'frikiland_des';
        //return 'bdx';
    }

}
