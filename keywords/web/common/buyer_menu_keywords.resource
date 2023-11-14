*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml

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


Go to "Manage Credit/Debit Note" list via ${url} and path uri ${uri}
    [Documentation]    Go to "Manage Credit/ Debit Note" list page
                ...    Parameters is URL and URI

    Go to buyer invoice system page    ${url}    ${uri}       


Change language '${lang_code}'
    Wait until loading complete
    Wait Until Element Is Visible    ${btn_lanuage}    ${timeout}
    click element    ${btn_lanuage}
    run keyword if    '${lang_code}' == 'EN'    Click Element   ${btn_lang_en}
    run keyword if    '${lang_code}' == 'TH'    Click Element   ${btn_lang_th}

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
Go to Manage invoice page by url
    #Wait Until Element Is Visible    //a[@class='list-tab-menu active']    ${TIMEOUT}
    Go To    ${EINVOICE_URL_WEB}${BUYER_STATUS_URI} 

Go to buyer invoice system page 
    [Arguments]    ${url}    ${uri}
    [Documentation]    Go to invoice system menu following URL and URI
                ...    URL is the URL of invoie system
                ...    URI is specific path

    Go to    ${url}${uri}               