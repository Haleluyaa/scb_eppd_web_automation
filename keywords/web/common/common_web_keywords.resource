*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml
Resource    ../../../resources/global_keyword.resource
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
*** Keywords ***
#### Open browser session #####
Go to eppd by chrome browser
    [Documentation]    Go to eppd endpoint by Login using Authen rounting api.
        ...            Arguments: Username, Password
    [Arguments]    ${username}    ${password}
    ${auth_resp}=   Post Authen rounting api    ${username}    ${password}
    ${url_auth}=   Set Variable    ${auth_resp}[generateTokenRs]
    open_eppd_by_chrome_browser    ${url_auth}




