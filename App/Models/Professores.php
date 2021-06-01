<?php

namespace App\Models;

class Alunos extends Usuarios{

    protected $tableName = "TBL_PROFESSORES";
    protected $procedure = "P_NEW_PROFESSOR";
    protected $viewName = "VIEW_PROFESSOR";

    public function __construct(){}

    public function fieldUpdateProfessor($field, $value){
        (new Database)->query("UPDATE INTO {$this->tableName} SET $field = $value, LOG_UPDATE = NOW() WHERE ID = {$this->data["ID"]}");
    }

    public function setEndereco($logradouro, $numero, $complemento, $bairro, $cidade, $estado, $pais){
        $result = (new Database)->select("CALL P_NEW_ENDERECO(:LOGRADOURO, :NUMERO, :COMPLEMENTO, :BAIRRO, :CIDADE, :ESTADO, :PAIS)",array(
            ":LOGRADOURO"=>$logradouro,
            ":NUMERO"=>$numero,
            ":COMPLEMENTO"=>$complemento,
            ":BAIRRO"=>$bairro,
            ":CIDADE"=>$cidade,
            ":ESTADO"=>$estado,
            ":PAIS"=>$pais
        ));

        $this->fieldUpdateProfessor(":ID_LOGRADOURO", $result[0]["ID"]);
    }

}