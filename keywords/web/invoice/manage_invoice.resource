
*** Settings ***
Variables    ../../../resources/locators/invoice/buyer_manage_invoice_list_locator.yaml

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
Verify success bar show ${success_bar_msg} and web redirect to invoice list page
    Success bar for create invoice must be    ${success_bar_msg}
    Verify page 'Manage invoice' display

Invoice '${inv_num}' status should be '${status}'
    Search invoice with search keyword    ${inv_num}   
    Verify manage invoice first row should have status      ${status}

Search invoice by invoice number "${invnum}"
    Click 'filter' dropdown list
    Select target filter     ${TEXT.INVOICE_NUMBER_TH}
    Search invoice with search keyword    ${invnum}   

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
Success bar for create invoice must be    
    [Arguments]  ${msg}
    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    ${actual_successbar}    Get Text     ${lbl_success_bar}   
    Should Contain Any    ${msg}    ${actual_successbar}

Verify page 'Manage invoice' display
    Wait Until Element Is Visible    ${btn_create_invoice}
    Element Should Be Visible    ${btn_create_invoice} 

Click 'filter' dropdown list
    Wait Until Element Is Visible    ${search_filter_section.ddl_inv_filter}
    Click element    ${search_filter_section.ddl_inv_filter}

Select target filter     
    [Arguments]     ${filter}
    ${target_obj}=    Replace Variables     ${search_filter_section.lbl_inv_filter}  
    Wait Until Element Is Visible    ${target_obj}   ${TIMEOUT}
    Click Element    ${target_obj}    

Search invoice with search keyword    
    [Arguments]     ${txt}  
    Wait until loading complete
    Run keyword if      '${txt}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${obj_search.txt_search}     ${timeout}
    ...     AND    clear element text  ${obj_search.txt_search} 
    ...     AND    Input Text    ${obj_search.txt_search}     ${txt}
    ...     AND    Click Element    ${obj_search.btn_search}
    ...     AND    Wait until loading complete 

Verify manage invoice first row should have status      
    [Arguments]     ${status}
    ${row}=     set variable    1
    ${status_locator}=  Replace variables   ${obj_inv_list.lbl_firstrow_data_status}
    Element text should be      ${status_locator}   ${status}
