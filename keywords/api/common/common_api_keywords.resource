*** Settings ***
Library    OperatingSystem
Library    RequestsLibrary
Library    Collections
Variables  ../../../mockdata_template/common-controller/login.yaml

***Keywords***
########################################################################################################################
# API Keywords
########################################################################################################################
Post Authen rounting api
    [Arguments]    ${username}    ${password}
    [Documentation]    post api with param : username@password
    ${headers}    Create Dictionary    Content-Type=application/x-www-form-urlencoded
        ...       X-Channel-Client=S1
        ...       X-Channel=MANUAL
    ${domain}    Set Variable    https://auth-scbeppd-${env}.se.scb.co.th/
    ${endpoint}  Set Variable    authen-routing/s1/auth/token
    ${x_form_body}=   Set Variable    ${authen_rounting.body}
    Set To Dictionary    ${x_form_body}    username    ${username}
    Set To Dictionary    ${x_form_body}    password    ${password}    
    Create Session    domain    ${domain}
    ${response}=    POST On Session   domain    ${endpoint}    headers=${headers}    data=${x_form_body}    expected_status=any
    ${res_json}=   Set Variable  ${response.json()}
    RETURN  ${res_json}


Response Should Be 200 OK
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 200 [OK]
    Should Be Equal As Integers    ${response.status_code}    200





