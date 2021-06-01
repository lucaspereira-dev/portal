<?php

namespace App\Controller;

use App\Models\{Alunos};

class Testes{

    public function Teste(){

       $user = new Alunos();

       $user->cadastro(
           "LUCASPEREIRA.DEV@OUTLOOK.COM",
           "88797263",
           Session::get("ID_SESSION"),
           "LUCAS PEREIRA",
           "10918781450",
           "209DI0"
       );

       var_dump($user->getAll());
    }

    public function recuperarSessionTeste($params){
        // var_dump($params);
        new Session($params["session"]);
        echo json_encode(Session::getAll());
    }
}