*** Settings ***
Resource         ../resources/ResourceBDD.robot
Resource         ../resources/BDDpt-br.robot

# *** Variables ***
# ${BASE_URL}    https://reqres.in
# # &{uri}         /api/users/2
# &{HEADERS}    Content-Type=application/json
# # ${response}
# # ${data}
# # ${Key}
# ${IdUser}
# # ${NAME}   George
# # ${JOB}    QA

*** Test Cases ***
Cenario: POST - Create
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um POST para o endpoint "api/users" com nome "George" e job "QA"
    Então status code da resposta sera 201
    E sera retornado no response a chave "id"
    
Cenario: GET - Single User
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um GET para o endpoint "/api/users/"
    Então status code da resposta sera 200

Cenario: PUT - Update
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um PUT para o endpoint "/api/users/" alterando os dados nome "George1" e job "QA1"
    Então status code da resposta sera 200

Cenario: DELETE
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um DELETE para o endpoint "/api/users/" para usuario criado
    Então status code da resposta sera 204

Cenario: Validar usuario deletado
    Dado que crie a sessao para "${BASE_URL}"
    Quando realizar um GET para o endpoint "/api/users/" para usuario deletado
    Então status code da resposta sera 200
    
# *** Keywords ***
# Dado que crie a sessao para "${url}"
#     Create Session    users    ${url}

# Quando realizar um GET para o endpoint "${uri}"
#     ${response}    GET On Session    users    ${uri}  ${IdUser}   headers=${HEADERS}
#     Set Test Variable    ${response}

# Quando realizar um GET para o endpoint "${uri}" para usuario deletado
#     ${response}    GET On Session    users    ${uri}  ${IdUser}   headers=${HEADERS}
#     Set Test Variable    ${response}
#     log to console  ${response.json()}
    
# Quando realizar um POST para o endpoint "${uri}" com nome "${NAME}" e job "${JOB}"
#     ${body}       Create Dictionary   name=${NAME}  job=${JOB}
#     ${response}    Post On Session     users    ${uri}    json=${body}    headers=${HEADERS}
#     Set Test Variable    ${response}
#     ${payload}=    Set Variable    ${response.json()}
#     ${IdUser}=     Set Variable    ${payload['id']}  
#     Should Contain    ${payload['name']}    ${NAME}
#     Should Contain    ${payload['job']}     ${JOB} 
#     Should Contain    ${payload['id']}      ${IdUser} 
#     log to console  ${response.json()}
#     log to console  ${IdUser}

# Quando realizar um PUT para o endpoint "${uri}" alterando os dados nome "${NAME}" e job "${JOB}"
#     ${body}       Create Dictionary   name=${NAME}  job=${JOB}
#     ${response}    Put On Session     users    ${uri}    json=${body}    headers=${HEADERS}
#     Set Test Variable    ${response}
#     ${payload}=    Set Variable    ${response.json()}
#     Should Contain    ${payload['name']}    ${NAME}
#     Should Contain    ${payload['job']}     ${JOB} 
#     log to console  ${response.json()}
#     log to console  ${IdUser}

# Quando realizar um DELETE para o endpoint "${uri}" para usuario criado
#     # ${body}       Create Dictionary   name=${NAME}  job=${JOB}
#     ${response}    DELETE On Session     users    ${uri}       headers=${HEADERS}
#     Set Test Variable    ${response}
#     # ${payload}=    Set Variable    ${response.json()}
#     # Should Contain    ${payload['name']}    ${NAME}
#     # Should Contain    ${payload['job']}     ${JOB} 
#     # log to console  ${response.json()}
#     # log to console  ${IdUser}

# Então status code da resposta sera ${status_code}
#     Should Be Equal As Numbers    ${response.status_code}    ${status_code}

# E sera retornado no response a chave "${Key}"
#     Should Contain    ${response.json()}    ${Key}
