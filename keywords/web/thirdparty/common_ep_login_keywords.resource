*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml
Variables    ../../../resources/locators/common/invoice_menu_locator.yaml
*** Keywords ***
########################################################################################################################
# KEYWORD LEVEL 1 : To Support BDD style
# PLEASE DO
#   1. Passing parameter in keyword's name, then pass it to keyword level 2.
#
# PLEASE DO NOT 
#   1. Access any LOCATOR.
#   2. Access any VARIABLE directly.
########################################################################################################################
Go to einvoice website from EP via "${site_name}" site with "${ep_username}" and "${ep_password}"
    Go to eInvoice via ep site, username and password    ${site_name}    ${ep_username}    ${ep_password}
    Wait until loading complete 
    Run Keyword And Ignore Error    Get access buyer cookie

Go to einvoice website from EP for "${eid}" via "${site_name}" site with "${ep_username}" and "${ep_password}"
    Go to eInvoice via ep site, username, password and eid    ${site_name}    ${ep_username}    ${ep_password}    ${eid}
    Wait until loading complete 
    Run Keyword And Ignore Error    Get access buyer cookie    

Go to einvoice website from EP via "${site_name}" site with "${ep_username}" and "${ep_password}" and go to cndn approve list    
    Go to eInvoice via ep site, username and password    ${site_name}    ${ep_username}    ${ep_password}
    Wait until loading complete 
    Get access buyer cookie
    Click menu cn/dn
    Go to menu Approve CN/DN

Go to einvoice website via SWW with "${sww_username}" and "${sww_password}"   
    Go to SWW
    Input Username And Password For Login Supplier Web Work    ${sww_username}    ${sww_password}
    Click Link Invoice Management On Supplier Web Work And Redirect To Invoice Management system 

Open einvoice website from EP via "${site_name}" site with "${ep_username}" and "${ep_password}"
    Go to    ${site_name}
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.1s
    Input username ep    ${ep_username}
    Input password ep    ${ep_password}
    Click login ep
    Redirect from ep to einvoice    ${env}
    Click Invoice Link
    
########################################################################################################################
# KEYWORD LEVEL 2 : Micro keyword
# PLEASE DO
#   1. Always keep it do small action.
#   2. Access LOCATOR.
#   3. Passing parameter by using [Arguments] tag
#
# PLEASE DO NOT 
#   1. Access any VARIABLE directly. (Allow only ${TIMEOUT})
########################################################################################################################
Input username ep
    [Arguments]    ${username}
    Wait Until Element Is Visible      ${txt_ep_username_locator}
    Input Text     ${txt_ep_username_locator}    ${username}

Input password ep
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${txt_ep_password_locator}
    Input Text    ${txt_ep_password_locator}    ${password}

Input eid ep
    [Arguments]    ${eid}=NULL

    ${count}    Get Element Count    ${txt_eid}

    Run Keyword And Return If    ${count}>0    Input eid to text box    ${eid}

Input eid to text box    
    [Arguments]    ${eid}

    Input Text    ${txt_eid}    ${eid}

Click login ep
    Wait Until Element Is Visible    ${btn_login_ep_locator}     
    click element   ${btn_login_ep_locator}    

Redirect from ep to einvoice
    [Arguments]    ${env}
    ${env}    Evaluate    "${env}".lower()
    ${site}=     Get Location
    ${count}    Get Element Count    ${msg_code_of_conduct}   

    Run Keyword If    ${count}>int(0)    Acknowledged code of conduct

    Run Keyword If    '${env}' == 'beta' or '${site}' == '${MTL_EP_HOME}'    Run Keywords
    ...    Wait Until Element Is Visible    ${beta_invoice_management_link_locator}    ${timeout}
    ...    AND     Click Element    ${beta_invoice_management_link_locator} 
    ...    ELSE IF    '${env}' == 'uat'    Run Keywords
    ...    Wait Until Element Is Visible    ${uat_invoice_management_link_locator}    ${timeout}
    ...    AND     Click Element    ${uat_invoice_management_link_locator}   
    ...    ELSE IF    '${env}'=='prod'    Run Keywords
    ...    Wait Until Element Is Visible    ${prod_invoice_management_link_locator}    ${timeout}
    ...    AND     Click Element    ${prod_invoice_management_link_locator} 

Acknowledged code of conduct
    Set Focus To Element    ${modal_code_of_conduct_tab}
    Scroll Element Into View    ${btn_acknowledged}
    Wait Until Element Is visible    ${btn_acknowledged}
    Click Element    ${btn_acknowledged}  

Go to SWW
    Open browser with ${SWW_WEB} and ${BROWSER}   
    Add local storage 'swwWeMallRemember' to browser
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.1s

Go to eInvoice via ep site, username and password
    [Arguments]    ${site_name}    ${ep_username}    ${ep_password}
    Open browser with ${site_name} and ${BROWSER}  
    Accept EP OptanonConsent on browser 
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.1s
    Input username ep    ${ep_username}
    Input password ep    ${ep_password}
    Click login ep
    Redirect from ep to einvoice    ${env}
    Click Invoice Link

Go to eInvoice via ep site, username, password and eid
    [Documentation]    Support login to EP with eid
    [Arguments]    ${site_name}    ${ep_username}    ${ep_password}    ${eid}
    Open browser with ${site_name} and ${BROWSER}   
    Accept EP OptanonConsent on browser
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.1s
    Input username ep    ${ep_username}
    Input password ep    ${ep_password}
    Input eid ep    ${eid}
    Click login ep
    Redirect from ep to einvoice    ${env}
    Click Invoice Link    

Logout from eInvoice
    Go to    ${EINVOICE_URL_WEB}${BUYER_STATUS_URI}
    Wait until loading complete
    Sign Out 

Sign Out
    ${menu_is_open}    Run Keyword And Return Status    element should be visible    ${signout_menu}
    Run Keyword If    '${menu_is_open}' == 'False'    Click To View User Profile Menu
    Click Element    ${signout_menu}     

Click To View User Profile Menu
    Click Element    ${icon_user_profile}     

Input Username And Password For Login Supplier Web Work
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${txt_sww_username}    ${TIMEOUT}
    Input Text    ${txt_sww_username}    ${username}
    Wait Until Element Is Visible    ${txt_sww_password}    ${TIMEOUT}
    Input Text    ${txt_sww_password}    ${password}
    Wait Until Element Is Visible    ${btn_sww_submit_login}    ${TIMEOUT}
    Click Element    ${btn_sww_submit_login}    

Click Link Invoice Management On Supplier Web Work And Redirect To Invoice Management system
    [Documentation]    This keyword for redirect to invoice management from supplier web work system
    Run Keyword If    '${env}' == 'beta' or '${env}' == 'prod'   Run Keywords
    ...     Wait Until Element Is Visible    ${lnk_sww_invoice}    ${TIMEOUT}
    ...     AND     Click Element    ${lnk_sww_invoice}    
    ...     ELSE IF    '${env}' == 'uat'    Run Keywords
    ...     Wait Until Element Is Visible    ${uat_lnk_sww_invoice}    ${TIMEOUT}
    ...     AND     Click Element    ${uat_lnk_sww_invoice}   

Add local storage 'swwWeMallRemember' to browser
    Execute Javascript    localStorage.setItem("swwWeMallRemember", true);
    Reload Page