*** Settings ***
Resource         ../resources/ResourceBDD.robot
Resource         ../resources/BDDpt-br.robot
# Suite Teardown   Fechar Navegador

*** Test Cases ***

Cenário 01: Iniciar Novo Cadastro
    Dado que eu esteja na tela HOME
    Quando eu informar Nome e Email
    E clicar no botão Signup
    Então sera Exibida a Tela de Cadastro com titulo "ENTER ACCOUNT INFORMATION"

Cenário 06: Validar Campos Obrigatorios
    Dado que os campos obrigatorios nao estejam preenchidos
    Quando clicar no botão Create Account 
    Então o cadastro nao sera realizados e sera exibida mensagem "Preencha esse campo."

Cenário 02: Validar Data de Aniversario
    Dado que esteja preenchendo os campos de "Date of Birth"
    Quando preencher os campos Day, Month e Year
    Então os campos serao preenchidos com sucesso

Cenário 03: Validar Password
    Dado que esteja preenchendo o campo "Password *"
    Quando preencher o campo password com dados alfanumericos
    Então o campo sera preenchido com sucesso

Cenário 04: Validar Address Information
    Dado que esteja preenchendo os campos de address information "ADDRESS INFORMATION"
    Quando preencher o campo First name
    E preencher o campo Last name
    E preencher o campo Company
    E preencher o campo Address
    E preencher o campo State
    E preencher o campo City
    E preencher o campo Zipcode
    E preencher o campo Mobile Number
    Então o campo sera preenchido com sucesso

Cenário 05: Validar Cadastro com Sucesso
    Dado que todos os campos estejam preenchidos
    Quando clicar no botão Create Account
    Então o cadastro sera realizado com sucesso e sera exibida a mensagem "ACCOUNT CREATED!"


