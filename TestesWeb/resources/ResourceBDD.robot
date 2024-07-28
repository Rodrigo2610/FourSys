*** Settings ***
Library     SeleniumLibrary
Library     FakerLibrary    locale=pt_BR
Library     String


*** Variables ***
${BROWSER}              chrome
${URL}                  https://automationexercise.com/login
${NAME}                 name=name               
${EMAIL}                xpath=.//input[contains(@data-qa,'signup-email')]
${BOTAO_SIGNUP}         xpath=./html/body/section/div/div/div[3]/div/form/button
${CAMPO_PESQUISAR}      css=.search-input>input
${BOTAO_PESQUISAR}      css=.search-action.flat-button
${LINK_POST}            xpath=.//*[@id='Blog1']/div[1]/article/div/div/h3/a
${TITULO_PAGE}          xpath=./html/body/section/div/div/div/div[1]/h2/b
${TITULODATE}           xpath=./html/body/section/div/div/div/div[1]/form/div[5]/label
${TITULOPASSWORD}       xpath=./html/body/section/div/div/div/div[1]/form/div[4]/label
${TITULOADDRESS}        xpath=./html/body/section/div/div/div/div[1]/form/h2/b
${INPUT_ADDRESS}        name=address1
${INPUTPASSWORD}        name=password
${CHECKBOX_NEWSLETTER}  name=newsletter
${CHECKBOX_RECEIVE}     name=optin
${INPUT_FIRST_NAME}     xpath=./html/body/section/div/div/div/div[1]/form/p[1]/input
${INPUT_LAST_NAME}      name=last_name
${INPUT_COMPANY}        name=company
${INPUT_STATE}          name=state
${INPUT_CITY}           name=city
${INPUT_ZIPCODE}       name=zipcode
${INPUT_MOBILENUMBER}   name=mobile_number
${BOTAO_CREATE_ACOUNT}  xpath=.//button[contains(@data-qa,'create-account')]
${DAYS}                 name=days
${MONTH}                name=months
${YEARS}                name=years        
${NUMBERS}              1234567890
${STATEFAKE}            SP
${CITYFAKE}             São Paulo
${MSGCADASTRO}          xpath=./html/body/section/div/div/div/h2/b

*** Keywords ***
#### DADO
que eu esteja na tela HOME
    Open Browser    ${URL}  ${BROWSER}

que esteja preenchendo os campos de "${DATEOFBIRTH}"
    validar date of birt ${DATEOFBIRTH}

que esteja preenchendo o campo "${PASSWORD}"
    validar campo password ${PASSWORD}

que esteja preenchendo os campos de address information "${ADDRESS}"
    validar campo address ${ADDRESS}

que todos os campos estejam preenchidos
    validar campos

que os campos obrigatorios nao estejam preenchidos
    campos obrigatorio nao preenchidos

#### QUANDO
eu informar Nome e Email
  preencher nome e email

preencher os campos Day, Month e Year
  preencher os campos de data

preencher o campo password com dados alfanumericos
  preencher password

preencher o campo First name
  preencher first name

clicar no botão Create Account
  cadastrar conta

#### E
clicar no botão Signup
    clicar botao
preencher o campo Last name
    preencher last name
preencher o campo Company
    preencher company
preencher o campo Address
    preencher address
preencher o campo State
    preencher state
preencher o campo City
    preencher city
preencher o campo Zipcode
    preencher zipcode
preencher o campo Mobile Number
    preencher mobile number
   
#### ENTÃO
sera Exibida a Tela de Cadastro com titulo "${TITULO}"
    validar titulo "${TITULO}"

validar date of birt ${DATEOFBIRTH}
    Element Text Should Be    ${TITULODATE}    ${DATEOFBIRTH}

o cadastro sera realizado com sucesso e sera exibida a mensagem "${MSGSUCESSO}"
    validar cadastro com sucesso ${MSGSUCESSO}
o campo sera preenchido com sucesso
    Sleep  2s

o cadastro nao sera realizados e sera exibida mensagem "${CAMPOBRIGATORIO}"
     Sleep  2s
    #  ${tooltip}   Get Element Attribute     ${INPUTPASSWORD}   value
    # #  Should Contain   ${tooltip}     (Optional) Please enter

    #  Element Text Should Be    ${tooltip}    ${CAMPOBRIGATORIO}

#### PASSOS   
preencher nome e email
    ${NOMEFAKE}    FakerLibrary.name
    Click Element   ${NAME}
    Sleep  2s
    Input Text  ${NAME}   ${NOMEFAKE} 
    log to console  ${NOMEFAKE}

    ${EMAILFAKE}   FakerLibrary.Email
    Click Element   ${EMAIL}
    Sleep  2s
    Input Text  ${EMAIL}   ${EMAILFAKE} 
    log to console  ${EMAILFAKE}
    Sleep  2s
clicar botao
    Click Element    ${BOTAO_SIGNUP}
    Sleep   2s
validar titulo "${TITULO}"
    Wait Until Element Is Visible  ${TITULO_PAGE}
    Element Text Should Be    ${TITULO_PAGE}    ${TITULO}
preencher os campos de data
    ${DATAFAKE}   FakerLibrary.Day Of Month
    log to console    This is a day: ${DATAFAKE}
    Select From List By Value    ${DAYS}    ${DATAFAKE} 
    
    ${ran int month}=    Evaluate    random.randint(0, 12)   random
    # ${ran int month}=    Convert To Integer    ${ran int month}
    log to console    This is a month: ${ran int month}
    Select From List By Value    ${MONTH}   ${ran int month}
    
    ${ran int year}=    Evaluate    random.randint(1900, 2021)    random
    ${ran int year}=    Convert To Integer    ${ran int year}
    log to console    This is a year: ${ran int year}
    Select From List By Value    ${YEARS}   ${ran int year} 

validar campo password ${PASSWORD}
    Element Text Should Be    ${TITULOPASSWORD}    ${PASSWORD}

preencher password
    ${PASSWORDFAKE}   FakerLibrary.Password
    Click Element   ${INPUTPASSWORD}
    Sleep  2s
    Input Text  ${INPUTPASSWORD}   ${PASSWORDFAKE} 
    log to console  his is a password: ${PASSWORDFAKE}
    Sleep  2s

validar campo address ${ADDRESS}
    # Scroll To Element
    #   [Arguments]  ${FIRSTNAMEFAKE}
    #   ${x}=        Get Horizontal Position  ${FIRSTNAMEFAKE}
    #   ${y}=        Get Vertical Position    ${FIRSTNAMEFAKE}
    #   Execute Javascript  window.scrollTo(${x}, ${y})
    Scroll Element Into View  xpath=./html/body/section/div/div/div/div[1]/form/p[6]/label
    Element Text Should Be    ${TITULOADDRESS}    ${ADDRESS}

preencher first name
    # Scroll Element Into View  ${INPUT_FIRST_NAME}
    Sleep  2s
    ${FIRSTNAMEFAKE}   FakerLibrary.first_name
    Click Element   ${INPUT_FIRST_NAME}
    Sleep  2s
    Input Text  ${INPUT_FIRST_NAME}   ${FIRSTNAMEFAKE} 
    log to console  his is a first name: ${FIRSTNAMEFAKE}
preencher last name
    ${LASTNAMEFAKE}   FakerLibrary.last_name
    Click Element   ${INPUT_LAST_NAME}
    Sleep  2s
    Input Text  ${INPUT_LAST_NAME}   ${LASTNAMEFAKE} 
    log to console  his is a last name: ${LASTNAMEFAKE}

preencher company
    Sleep  2s
    ${COMPANYFAKE}   FakerLibrary.Job
    Click Element   ${INPUT_COMPANY}
    Sleep  2s
    Input Text  ${INPUT_COMPANY}   ${COMPANYFAKE} 
    log to console  his is a company name: ${COMPANYFAKE}

preencher address
    Sleep  2s
    Scroll Element Into View  xpath=./html/body/section/div/div/div/div[1]/form/p[10]/label
    ${ADDRESSFAKE}   FakerLibrary.Address
    Click Element   ${INPUT_ADDRESS}
    Sleep  2s
    Input Text  ${INPUT_ADDRESS}   ${ADDRESSFAKE} 
    log to console  his is a address name: ${ADDRESSFAKE}

preencher state
    Sleep  2s
    Scroll Element Into View  xpath=./html/body/section/div/div/div/div[1]/form/button
    Click Element   ${INPUT_STATE}
    Sleep  2s
    Input Text  ${INPUT_STATE}   ${STATEFAKE} 
    log to console  his is a state name: ${STATEFAKE}

preencher city
    Sleep  2s
    Click Element   ${INPUT_CITY}
    Sleep  2s
    Input Text  ${INPUT_CITY}   ${CITYFAKE} 
    log to console  his is a city name: ${CITYFAKE}

preencher zipcode
    Sleep  2s
    ${ZIPCODEFAKE}   FakerLibrary.Postcode
    Click Element   ${INPUT_ZIPCODE}
    Sleep  2s
    Input Text  ${INPUT_ZIPCODE}   ${ZIPCODEFAKE} 
    log to console  his is a zipcode name: ${ZIPCODEFAKE}
    Press Keys    ${INPUT_ZIPCODE}    TAB

preencher mobile number
    Sleep  2s
    ${MOBILENUMBERFAKE}   FakerLibrary.Phone Number
    Click Element   ${INPUT_MOBILENUMBER}
    Sleep  2s
    Input Text  ${INPUT_MOBILENUMBER}   ${MOBILENUMBERFAKE} 
    log to console  his is a mobile number name: ${MOBILENUMBERFAKE}
validar campos
    Sleep  2s
cadastrar conta
    Sleep  2s
    Click Element   ${BOTAO_CREATE_ACOUNT}

validar cadastro com sucesso ${MSGSUCESSO}
    Sleep  2s
    Element Text Should Be    ${MSGCADASTRO}    ${MSGSUCESSO}

campos obrigatorio nao preenchidos
     Scroll Element Into View  xpath=./html/body/section/div/div/div/div[1]/form/button
     Click Element   ${INPUT_MOBILENUMBER}
     Sleep  8s
# campos obrigatorios ${CAMPOBRIGATORIO}
#      Sleep  2s
#      Element Text Should Be    ${TOOLTIP}    ${CAMPOBRIGATORIO}
    
#### TEARDOWN
# Fechar Navegador
    # Close Browser
