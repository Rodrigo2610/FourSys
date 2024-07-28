*** Settings ***
Resource         ../resources/ResourceBDD.robot
Resource         ../resources/BDDpt-br.robot

*** Test Cases ***
Cenario: POST - Create
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um POST para o endpoint "api/users" com nome "George" e job "QA"
    Então status code da resposta sera 201
    E o schema sera validado
    E o tipo do campo sera validado
    E sera retornado no response a chave "id"
    
Cenario: GET - Single User
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um GET para o endpoint "/api/users/"
    Então status code da resposta sera 200
    E o tipo do campo sera validado

Cenario: PUT - Update
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um PUT para o endpoint "/api/users/" alterando os dados nome "George1" e job "QA1"
    Então status code da resposta sera 200
    E o tipo do campo sera validado

Cenario: DELETE
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um DELETE para o endpoint "/api/users/" para usuario criado
    Então status code da resposta sera 204

Cenario: Validar usuario deletado
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um GET para o endpoint "/api/users/" para usuario deletado
    Então status code da resposta sera 200
    E o tipo do campo sera validado
