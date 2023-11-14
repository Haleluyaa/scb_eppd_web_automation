#*** Settings ***
#Variables    ../../../resources/locators/common/common_locators.yaml
#Variables    ../../../resources/locators/invoice/buyer_approve_invoice_list_locator.yaml

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
Go to "Approve CNDN" via URL on "${url}" and "${uri}"    
    Go to specific page    ${url}    ${uri}    







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
Go to specific page
    [Arguments]    ${url}    ${uri}
    Go to   ${url}${uri}
    Wait until loading complete
