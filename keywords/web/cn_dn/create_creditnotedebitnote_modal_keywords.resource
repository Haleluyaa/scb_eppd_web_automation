*** Settings ***
Variables    ../../../resources/locators/cn_dn/create_creditnotedebitnote_modal_locator.yaml

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
Go to invoice step1 for create credit note from ${buyer_name} and ${currency}
    [Documentation]    Go to create invoice step_1 page from select buyer and currency
                ...    then click next button
    Go to create credit note debit note modal
    Click radio button credit note
    Select buyer from dropdown list for create cndn    ${buyer_name} 
    Select currency from dropdown list for create cndn    ${currency} 
    Click continue button to invoice step 1

Waiting modal create credit debit note visible
    [Documentation]    wait until modal create credit, debit note display on screen
    Wait until element is visible    ${mdl_create_cndn_locator}

Click radio button credit note
    [Documentation]    choose radio button credit note
    Waiting modal create credit debit note visible
    Wait until element is visible    ${rdo_invoice_type_creditnote_locator}
    Click element    ${rdo_invoice_type_creditnote_locator}

Click radio button debit note
    [Documentation]    choose radio button debit note
    Waiting modal create credit debit note visible
    Wait until element is visible    ${rdo_invoice_type_creditnote_locator}
    Click element    ${rdo_invoice_type_creditnote_locator}    

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
Click continue button to invoice step 1
    Wait until element is visible    ${btn_continue_enabled_locator}
    Click element    ${btn_continue_enabled_locator}

Select buyer create credit note or debit note from search by ${buyer_name}
    Wait until element is visible    ${ddl_selected_buyer_cndn_locator}
    Click element    ${ddl_selected_buyer_cndn_locator}   
    Wait until element is visible    ${txt_search_buyer_cndn_locator}
    Input text    ${txt_search_buyer_cndn_locator}    ${buyer_name}
    #Click element      
    ${selected_buyer_locator}    Replace ${list_select_buyer_cndn_locator} from 'REPLACE_ME' to ${buyer_name}
    Click element    ${selected_buyer_locator}                

Select buyer from dropdown list for create cndn
    [Arguments]    ${buyer}
    [Documentation]    choose buyer from dropdown list by buyer name
    Wait until element is visible    ${ddl_selected_buyer_cndn_locator}
    Click element    ${ddl_selected_buyer_cndn_locator}
    ${selected_buyer_locator}    Replace ${list_select_buyer_cndn_locator} from 'REPLACE_ME' to ${buyer}
    Click element    ${selected_buyer_locator}

Select currency from dropdown list for create cndn    
    [Arguments]    ${currency_code}
    [Documentation]    choose currecy from drop  down list by currency code
    Wait until element is visible    ${ddl_currency_cndn_locator}
    Click element    ${ddl_currency_cndn_locator}
    log    ${currency_code}

    ${currency_code_locator}    Replace ${list_currency_cndn_locator} from 'REPLACE_ME' to ${currency_code}

    Click element    ${currency_code_locator}