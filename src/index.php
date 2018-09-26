<?php

require "../vendor/autoload.php";

/**
 * Incluindo a Framework Flight
 */
// require 'flight/Flight.php';
/**
 * Incluindo a Biblioteca ORM - NotORM
 */
// include "NotORM.php";

/**
 * Modelo de link para consulta nas requisições
 */ 


/** 
 * Requisição de todas as categorias de documentos.
 * Os dados retornados devem ser apenas os nomes das categorias.
 * # sem parâmetros
 * @return json array em formato de arquivo json
 */
Flight::route('/hm/categorias/list', function(){
    $retorno = array(
        "categorias" => array(
            "jornais",
            "livros",
            "cartas",
            "outros",            
        )
    );
    Flight::json($retorno);
    //if(isset($quantidade)) echo "<br>Quantidade - ".$quantidade;
});

/** 
 * Consulta de uma categoria especificada por algum código único (ID).
 * @param string $id é identificador único de uma categoria.
 * @param int $many flag que identifica se é preciso verificar se o parâmetro id 
 * será um array de ids. Caso o parâmetro em $many for igual a 1, o parâmetro id
 * deve ser tratado com um array.
 * @return json array em formato de arquivo json com as categorias
 */
Flight::route('/hm/categorias/@id(/@many)', function($id, $many = null){
    if(isset($id)){
        /**
         * Caso a flag many estiver setada como 1, quer dizer que serão
         * muitos ID. Nesse caso, será necessário retornar varias
         * categorias por diversos IDs.
         * Para isso, utilizar PHP explode('|', $id) para retornar um array
         * com os IDs.
         */
        
        if(isset($many) && $many == 1){
            /** 
             * Criando um array com a função explode do PHP, com o delimitador
             * |
             */
            $id = explode("|", $id);
            /**
             * realiza a consulta e retorna os dados
             */
        }else{
            
        }
        
        /**
         * Realiza a consulta no banco de dados
         */
        $retorno = array();
        
        Flight::json($retorno);
    }else{
        /**
         * Retorna um parâmetro false
         */
        Flight::json(false);
        
    }
});

/**
 * Função para buscar por categorias através da busca por valor em banco de dados.
 * É possível pesquisar por nome da categoria, por exemplo, utilizando critérios 
 * de consulta SQL.
 * 
 * @param string $param tipo de parâmetro que será possível buscar no banco
 * - tipos possível: [nome] 
 * @param string $value Valor utilizado para buscar no banco de dados
 */
Flight::route('/hm/categorias/@param/@value', function($param, $value){
    
    if(isset($param) && isset($value)){
        /**
         * Realiza a consulta no banco de dados
         */
        $retorno = array();
        
        Flight::json($retorno);        
    }else{
        /**
         * Retorna um parâmetro false
         */
        Flight::json(false);
        
    }
});



/************************* INICIALIZANDO O FRAMEWORK *********************/
Flight::start();
