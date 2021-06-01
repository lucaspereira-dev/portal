<?php

include_once "../vendor/autoload.php";


use Router\Web;

$route = new Web(
    $_SERVER["REQUEST_METHOD"], 
    $_SERVER["REQUEST_URI"] ?? "/"
);

$route->get("/", function(){
    Web::View("login@index.html");
});

$route->post("/","App\\Controller\\teste@postMethod");

$route->get("/cadastro", function(){
    Web::View("cadastro@index.html");
});

$route->get("/testes/{session}", "App\\Controller\\Testes@recuperarSessionTeste");

$route->post("/cadastro", "App\\Controller\\User@cadastro");

// $route->get("/testes", "App\\Controller\\Testes@Teste");

$route->get("/testes", function(){
    Web::View("ViewTeste@index.html");
});



$route->run();