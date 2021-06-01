<?php

namespace App\Models;

abstract class Usuarios{

    protected $data = [];
    protected $tableName = "";
    protected $procedure = "";
    protected $procedureParams = "";
    protected $viewName = "";

    public function __construct(String $email, String $password)
    {
        $this->login($email, $password);
    }

    public function login(String $email, String $password){

        $database = new Database();

        $result = $database->select("SELECT * FROM {$this->viewName} WHERE EMAIL = :EMAIL AND PASSWORD_LOGIN = :PASSWORD_LOGIN",
        array(
            ":EMAIL"=>$email,
            ":PASSWORD_LOGIN"=>$password
        ));

        foreach($result as $key=>$value){
            $this->data[$key] = $value;
        }
    }

    public function checkUser(){
        return isset($this->data["ID"]);
    }

    public function cadastro($email, $password, $cookie_session, $nome, $cpf, $matricula){

        $database = new Database();
        $result = $database->select("CALL {$this->procedure} ({$this->procedureParams});", array(
            ":EMAIL"=>$email,
            ":PASSWORD"=>sha1($password),
            ":COOKIE_SESSION"=>$cookie_session,
            ":NOME"=>$nome,
            ":CPF"=>$cpf,
            ":MATRICULA"=>$matricula
        ));

        foreach($result[0] as $key=>$value){
            $this->data[$key] = $value;
        }
    }

    public function fieldUpdateLogin($field, $value){
        (new Database)->query("UPDATE INTO TBL_LOGIN SET $field = $value, LOG_UPDATE = NOW() WHERE ID_USER = {$this->data["ID"]}");
    }

    public function __get($name)
    {
        return $this->date[$name];
    }

    public function __set($name, $value)
    {
        $this->date[$name] = $value;
    }

    public function getAll(){
        return $this->data;
    }

}