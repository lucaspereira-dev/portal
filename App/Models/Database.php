<?php

namespace App\Models;

use \PDO;
use \Exception;

class Database extends PDO{

    private const DRIVE = "mysql";
    private const HOST = "localhost";
    private const PORT = "mysql";
    private const BDNAME = "PORTAL";
    private const LOGIN = "lucas";
    private const PASSWORD = "1046";

    private $conn;

    public function __construct(){
        try{
            $this->conn = new PDO(self::DRIVE .":host=". self::HOST .";port=". self::PORT .";dbname=". self::BDNAME, self::LOGIN, self::PASSWORD);
        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    private function setParams($statment, $parameters = array()){

        foreach($parameters as $key=>$value){
            $this->setParam($statment, $key, $value);
        }
    }

    private function setParam($statment, $key, $value){
        $statment->bindParam($key, $value);
    }

    private function setQuery($rawQuery, $params = array()){

        $stmt = $this->conn->prepare($rawQuery);
        $this->setParams($stmt, $params);
        $stmt->execute();
        return $stmt;
    }

    public function select($rawQuery, $params = array()){

        $stmt = $this->setQuery($rawQuery, $params);
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}