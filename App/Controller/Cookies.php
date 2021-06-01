<?php

namespace App\Controller;

class Cookies{

    private const TIME = 60 * 60 * 24; // Segundo * Minutos * Horas * (Dias)

    // Como padrão colocando o cookie para 30 dias
    public static function set($name, $value, $expire = 30){
        setcookie($name, $value, (time() + (self::TIME * $expire)));
    }

    public static function get(String $name){
        return $_COOKIE[$name];
    }

    public static function destroy(String $name){
        unset($_COOKIE[$name]);
        setcookie($name, "");
    }
}