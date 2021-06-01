<?php

namespace App\Controller;

use DateTime;

class Session{

    // Tempo de regeneração do ID de sessão
    private const TIME_GERENERATION = 10; // Minutos

    public static function get(String $key){
        self::sessionInit();
        return $_SESSION[$key];
    }

    public static function setArray(Array $items){
        self::sessionInit();
        foreach($items as $key=>$item){
            $_SESSION[$key] = $item;
        }
    }

    public static function set(String $key, String $value){
        self::sessionInit();
        $_SESSION[$key] = $value;
    }

    public static function getAll(){
        self::sessionInit();
        return $_SESSION;
    }

    private static function regeneration(){

        // self::sessionInit();

        $creationTime = date_create($_SESSION["CREATION_TIME"]);
        $time = date_create();
        $interval = date_diff($creationTime, $time);

        // Verificar tempo de invervalo
        // echo "<p>".$creationTime->format("h:i:s")."</p>";
        // echo "<hr>";
        // echo "<p>".$interval->format("%h:%i:%s")."</p>";
        // echo "<hr>";
        // echo "<p>ID de Sessão: ".$_SESSION["ID_SESSION"]."</p>";

        if($interval->format("%i") >= self::TIME_GERENERATION){

            session_regenerate_id();
            
            $_SESSION['ID_SESSION'] = session_id();
            $_SESSION['CREATION_TIME'] = date_create()->format("d-m-Y H:i:s");
            Cookies::set("ID_SESSION", Session::get('ID_SESSION'));
        }
    }

    public static function destroy(){
        self::sessionInit();
        session_destroy();
    }

    public static function idSession(){
        self::sessionInit();
        return session_id();
    }

    private static function sessionInit(){

        session_status() === PHP_SESSION_ACTIVE ?: session_start();

        // Por enquanto vou deixar ele no automatico  
        self::regeneration();
        
        if(!isset($_SESSION['CREATION_TIME'])){
            $_SESSION['CREATION_TIME'] = date_create()->format("d-m-Y H:i:s");
            $_SESSION['ID_SESSION'] = session_id();
        }
    }
}