<?php

namespace App\Models;

class Alunos extends Usuarios{

    protected $tableName = "TBL_ALUNOS";
    protected $procedure = "P_NEW_ALUNO";
    protected $viewName = "VIEW_ALUNOS";

    public function __construct(){}

    public function fieldUpdateAluno($field, $value){
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

        $this->fieldUpdateAluno(":ID_LOGRADOURO", $result[0]["ID"]);
    }

    public function getDisciplinas(){
        $result = (new Database)->select("SELECT * FROM VIEW_CALENDARIO_DISCIPLINAS WHERE ID IN (SELECT ID_DISCIPLINA FROM TBL_CALENDARIO_ALUNOS WHERE ID_ALUNO = :ID);",
        array(
            ":ID"=>$this->data["ID"]
        ));

        return $result;
    }

    public function getDisciplina($idDisciplina){
        $result = (new Database)->select("SELECT * FROM VIEW_CALENDARIO_ALUNOS WHERE ID_CALENDARIO_DISCIPLINA = :ID_DISCIPLINA;",
        array(
            ":ID_DISCIPLINA"=>$idDisciplina
        ));

        return $result;
    }

}