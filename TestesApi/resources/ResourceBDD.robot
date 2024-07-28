*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    Process
Library    FakerLibrary    locale=pt_BR
Library    jsonschema

*** Variables ***
${BASE_URL}    https://reqres.in
# &{uri}         /api/users/2
&{HEADERS}    Content-Type=application/json
${response}
${data}
${Key}
${IdUser}
${payload}
${NAME}   George
${JOB}    QA
${status_code}

*** Keywords ***

#### DADO
que crie a sessao para "${url}"
    Create Session    users    ${url}

#### QUANDO
realizar um GET para o endpoint "${uri}"
    ${response}    GET On Session    users    ${uri}  ${IdUser}   headers=${HEADERS}
    Set Test Variable    ${response}

realizar um GET para o endpoint "${uri}" para usuario deletado
    ${response}    GET On Session    users    ${uri}  ${IdUser}   headers=${HEADERS}
    Set Test Variable    ${response}
    log to console  ${response.json()}
    
realizar um POST para o endpoint "${uri}" com nome "${NAME}" e job "${JOB}"
    ${body}       Create Dictionary   name=${NAME}  job=${JOB}
    ${response}    Post On Session     users    ${uri}    json=${body}    headers=${HEADERS}
    Set Test Variable    ${response}
    ${payload}=    Set Variable    ${response.json()}
    ${IdUser}=     Set Variable    ${payload['id']}  
    Should Contain    ${payload['name']}    ${NAME}
    Should Contain    ${payload['job']}     ${JOB} 
    Should Contain    ${payload['id']}      ${IdUser} 
    log to console  ${response.json()}
    log to console  ${IdUser}

realizar um PUT para o endpoint "${uri}" alterando os dados nome "${NAME}" e job "${JOB}"
    ${body}       Create Dictionary   name=${NAME}  job=${JOB}
    ${response}    Put On Session     users    ${uri}    json=${body}    headers=${HEADERS}
    Set Test Variable    ${response}
    ${payload}=    Set Variable    ${response.json()}
    Should Contain    ${payload['name']}    ${NAME}
    Should Contain    ${payload['job']}     ${JOB} 
    log to console  ${response.json()}
    log to console  ${IdUser}

realizar um DELETE para o endpoint "${uri}" para usuario criado
    # ${body}       Create Dictionary   name=${NAME}  job=${JOB}
    ${response}    DELETE On Session     users    ${uri}       headers=${HEADERS}
    Set Test Variable    ${response}
    # ${payload}=    Set Variable    ${response.json()}
    # Should Contain    ${payload['name']}    ${NAME}
    # Should Contain    ${payload['job']}     ${JOB} 
    # log to console  ${response.json()}
    # log to console  ${IdUser}

#### ENTÃO
status code da resposta sera ${status_code}
    Should Be Equal As Numbers    ${response.status_code}    ${status_code}

#### E
o schema sera validado
    ${schema}    Get Binary File    ../resources/Schema.json
    ${schema}    evaluate    json.loads('''${schema}''')    json
    validate    ${payload}    schema=${schema}

sera retornado no response a chave "${Key}"
    Should Contain    ${response.json()}    ${Key}

o tipo do campo sera validado
     Log To Console        \n
     FOR    ${item}    IN    @{response.json()}
         ${res}=     Evaluate    "${item}".isalnum() 
         Log To Console    Is Item:${item} Alphanumeric: ${res}        
     END