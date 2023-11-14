*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml
#Variables    ../../../resources/locators/invoice/invoice_locator.yaml
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
Search invoice by keyword equal "${keyword}" and invoice status equal "${invoice_status}" 
    Select invoice status on dropdown    ${invoice_status}
    Search invoice by search keyword on manage invoice page    ${keyword}

Go to manage invoice status detail page
    Click on first row from search result    

Filter invoice with status "${invoice_status}"
    Click drop down list for select status
    Click seleced status in drop down list panel    ${invoice_status}             

User clicked action button on row ${row_number}
    Click action number on selected row    ${row_number}  

User choose invoice options "${action}" at row "${row_ number}"
    Choose invoice action from options list   ${action}    ${row_ number}

User get invoice data for validate from invoice list invoice on row "${row_num}"  
    Get invoice num on selected row number    ${row_num}
    Get buyer name on selected row number    ${row_num}
    Get invoice create date on selected row number    ${row_num}    

User click on specificed invoice row "${row_number}" at column "${column_no}" 
    Click on specificed row at specificed column     ${row_number}    ${column_no} 

Go to manage invoice list    
    Go to manage invoice list page

Buyer user choose filter tax invoice condition 'With Tax Invoice' in invoice status
    Click icon filter tax invoice
    Choose filter tax invoice condition 'With Tax Invoice'

Buyer user choose filter tax invoice condition 'No Tax Invoice' in invoice status
    Click icon filter tax invoice
    Choose filter tax invoice condition 'No Tax Invoice'    

Buyer user choose filter tax invoice condition 'All Invoice' in invoice status
    Click icon filter tax invoice
    Choose filter tax invoice condition 'No Tax Invoice'    

Invoice data show only invoice had 'Tax Invoice' in invoice status
    Verify invoice status show only invoice had tax invoice number

Invoice data show invoice had 'No Tax Invoice' in invoice status
    Verify invoice status not show invoice had tax invoice number 

Invoice data show both invoice had 'Tax Invoice' and 'No Tax Invoice' in invoice status    
    Verify invoice staus show both invoice had tax invoice and not tax invoice      


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
Go to manage invoice list page
    Go To    ${EINVOICE_URL_WEB}${BUYER_STATUS_URI}

Loop for select status and search invoice by type then verify action
    [Arguments]    ${site_code}    ${jsonfile}    ${users}    ${user_index}    
    ${inv_type_obj}=    Get Json Value in file And Convert To Object    ${jsonfile}     /${site_code}/user/${user_index}/invoice_type
    ${inv_type_num}=    Get Length    ${inv_type_obj}
    :FOR    ${i}    IN RANGE    0    ${inv_type_num} 
    \   ${inv_type}   Get Json Value    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${i}/id
    \   Set Test Variable       ${inv_type}
    \   Loop select status by statusid     ${i}     ${site_code}    ${jsonfile}    ${user_index}

Loop select status by statusid
    [Arguments]    ${type_id}     ${site_code}    ${jsonfile}    ${user_index}
    ${inv_status_obj}=    Get Json Value in file And Convert To Object    ${jsonfile}        /${site_code}/user/${user_index}/invoice_type/${type_id}/data
    ${inv_status_num}=    Get Length    ${inv_status_obj}
    :FOR    ${i}    IN RANGE    0    ${inv_status_num}
    \   ${inv_status}   Get Json Value    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${type_id}/data/${i}/invoice_status 
    \   ${inv_number}   Get Json Value    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${type_id}/data/${i}/invoice_number    
    # \   ${inv_number}=       Evaluate     ${inv_number}.replace('"','')    fail with Py3
    \   ${inv_number}=       Replace String     ${inv_number}    "    ${EMPTY}
    \   ${inv_action_obj}   Get Json Value in file And Convert To Object    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${type_id}/data/${i}/action 
    \   ${user_action} =	Get Dictionary Keys     ${inv_action_obj}  
    \   Set Test Variable       ${inv_status}
    \   Set Test Variable       ${inv_number}
    \   Select invoice status on dropdown    ${inv_status}
    \   Search invoice by search keyword on manage invoice page     ${inv_number}
    \   Verify action displayed correctly in case search result found    ${user_action}    

Select invoice status on dropdown
    [Arguments]    ${keyword_search}    
    Wait Until Element Is Visible    ${ddl_buyer_status_search_invoice_status_locator}    ${TIMEOUT}
    Click Element    ${ddl_buyer_status_search_invoice_status_locator}
    ${ddl_buyer_status_search_invoice_in_status_locator}=    Replace String    ${ddl_buyer_status_search_invoice_in_status_locator}    REPLACE_ME    \"${keyword_search}\"
    Wait Until Element Is Visible    ${ddl_buyer_status_search_invoice_in_status_locator}    ${TIMEOUT}
    Click Element    ${ddl_buyer_status_search_invoice_in_status_locator}
    Wait until loading complete

Search invoice by search keyword on manage invoice page
    [Arguments]    ${keyword_search}
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${txt_input_criteria_buyer_manage_invoice}     ${timeout}
    ...     AND     clear element text  ${txt_input_criteria_buyer_manage_invoice}
    ...     AND     Input Text    ${txt_input_criteria_buyer_manage_invoice}    ${keyword_search}
    ...     AND     Click Element    ${btn_search_button_buyer_manage_invoice}
    ...     AND     Wait until loading complete
    Log     ${keyword_search}

Verify action displayed correctly in case search result found  
    [Arguments]     ${user_action} 
    ${number}   set variable    1
    ${Hasdata}=     Run Keyword And Return Status    Wait Until Element Is Visible   ${tbl_manage_invoice_count_result}
    Run keyword if      '${Hasdata}' == 'True'  
    
    ...     Run Keywords        
    ...     Click on dot button at row number for expand action      ${number}
    ...     AND     Verify action data at row number by compare with action list     ${number}    ${user_action}   

Click on dot button at row number for expand action
    [Arguments]    ${number}
    Wait Until Element Is Visible    ${btn_expand_action_approve_list}${number}    ${timeout}
    Click Element    ${btn_expand_action_approve_list}${number}

Verify action data at row number by compare with action list
    [Arguments]     ${number}   ${expected_list} 
    ${Expected_count}   Get Length   ${expected_list}
    ${count}=  Get element count   //div[@id="rb-ddl-action-selected-${number}"]/ul/li
    Should be equal     ${count}    ${Expected_count}   type:${inv_type}-invnum:${inv_number}-status:${inv_status} Action number expected not equal to actual
    :FOR     ${i}    IN RANGE    1    ${count} + 1        
    \   ${action_item}      Get text    //div[@id="rb-ddl-action-selected-${number}"]/ul/li[${i}]
    \   List Should Contain Value  ${expected_list}  ${action_item}     type:${inv_type}-invnum:${inv_number}:${inv_status}-status: Action menu wrong

Get user data in json append to list from
    [Arguments]    ${user_name}    ${json_path}    ${site_code}
    Set Suite Variable    ${curdir}    ${CURDIR}      #Peng issue that Unknown ${CURDIR}
    ${json_path}=  Replace Variables    ${json_path}
    ${jsonfile}    Get File    ${json_path}   
    ${users}=    Get json value in file and convert to object    ${jsonfile}        /${site_code}/user
    ${user_index}=  get_user_index_from_list_by_value    ${users}     ${user_name}   
    [Return]   ${jsonfile}    ${users}    ${user_index}

Click on first row from search result    
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice.invoice_list.tbl_first_row}    ${TIMEOUT}
    Click Element    ${obj_invoice.invoice_list.tbl_first_row} 

Click drop down list for select status
    Wait until loading complete
    Wait Until Element Is Visible    ${ddl_filter_invoice_status['selected_status']} 
    Click Element    ${ddl_filter_invoice_status['selected_status']}

Click seleced status in drop down list panel    
    [Arguments]    ${invoice_status}

    ${target_status}    Replace Variables    ${ddl_filter_invoice_status['options_val']}

    Wait Until Element Is Visible   ${target_status}   ${TIMEOUT}
    Click Element    ${target_status}

Click action number on selected row
    [Arguments]    ${row_num}

    ${target_row}    Replace Variables    ${btn_action_dot}

    Wait until loading complete
    Wait Until Element Is Visible    ${target_row}    ${TIMEOUT} 
    Click Element    ${target_row}

Choose invoice action from options list  
    [Arguments]    ${action}    ${row_num}

    ${target_action}    Replace Variables    ${invoice_action['history']}

    ${row_number}    Evaluate    ${row_num}-1
    Wait Until Element Is Visible     ${target_action}    ${TIMEOUT}
    Click Element    ${target_action}

Get invoice num on selected row number
    [Arguments]    ${row_num}

    Wait until loading complete
    ${target_cel}    Replace Variables    ${tbl_manage_invoice_list['cel_invoice_num_on_row']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_invoice_num}    Get Text    ${target_cel}

    Set Test Variable    ${TV_invoice_num}

Get buyer name on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_manage_invoice_list['cel_buyer_name_on_row']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_buyer_name}    Get Text    ${target_cel}

    Set Test Variable    ${TV_buyer_name}

Get invoice create date on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_manage_invoice_list['cel_created_date_on_row']}

    Wait Until Element Is Visible     ${target_cel}    ${TIMEOUT} 
    ${TV_invoice_create_date}    Get Text    ${target_cel}

    Set Test Variable    ${TV_invoice_create_date}     

Click on specificed row at specificed column
    [Arguments]    ${row_num}    ${ret_col_no}

    ${target_row}    Replace Variables    ${tbl_manage_invoice_list['row_specified']}   
    Wait until loading complete
    Wait Until Element Is Visible    ${target_row}    ${TIMEOUT}
    Click Element    ${target_row}    

Click icon filter tax invoice
    [Documentation]    Clicked icon filter tax invoice on table header

    Wait until loading complete
    Wait Until Element Is Visible     ${filter_tax_invoice['icon_filter']}    ${TIMEOUT}
    Click Element    ${filter_tax_invoice['icon_filter']}

Choose filter tax invoice condition 'With Tax Invoice'
    [Documentation]    Choose filter tax invoice option 'With Tax Invoice'

    Wait Until Element Is Visible    ${filter_tax_invoice['with_tax_invoice']}    ${TIMEOUT}
    Click Element    ${filter_tax_invoice['with_tax_invoice']}

Choose filter tax invoice condition 'No Tax Invoice' 
    [Documentation]    Choose filter tax invoice option 'No Tax Invoice'

    Wait Until Element Is Visible    ${filter_tax_invoice['no_tax_invoice']}    ${TIMEOUT}
    Click Element    ${filter_tax_invoice['no_tax_invoice']} 

Choose filter tax invoice condition 'All Invoice' 
    [Documentation]    Choose filter tax invoice option 'All Invoice'

    Wait Until Element Is Visible    ${filter_tax_invoice['all_invoice']}    ${TIMEOUT}
    Click Element    ${filter_tax_invoice['all_invoice']}             

Verify invoice status show only invoice had tax invoice number
    [Documentation]    Verify invoice list show only number had Tax Invoice
                ...    Verify by compare all data in list equal data had Tax Invoice

    Wait until loading complete

    ${count}    Get Element Count    ${tbl_manage_invoice_list['row_all']}

    Run Keyword If    ${count}>int(0)    Comparation all row in invoice status equal filter with tax invoice number
    ...    ELSE    Verify invoice status is empty

Comparation all row in invoice status equal filter with tax invoice number

    Wait Until Element Is Visible    ${tbl_manage_invoice_list['row_first']}    ${TIMEOUT}

    ${cnt_icon_tax}    Get Element Count    ${tbl_manage_invoice_list['cel_span_invoice_num_tax_icon']}   
    ${cnt_row_all}    Get Element Count    ${tbl_manage_invoice_list['row_all']} 

    Should Be Equal    ${cnt_icon_tax}    ${cnt_row_all}

Verify invoice status not show invoice had tax invoice number
    [Documentation]    Verify invoice list show only number had Tax Invoice
                ...    Verify by invoice had Tax Invoice equal zero

    Wait until loading complete    
    ${count}    Get Element Count    ${tbl_manage_invoice_list['row_all']}
    
    Run Keyword If    ${count}>int(0)    Comparation all row in invoice status equal filter with no tax invoice number
    ...    ELSE    Verify invoice status is empty

Comparation all row in invoice status equal filter with no tax invoice number    
    Wait Until Element Is Visible    ${tbl_manage_invoice_list['row_first']}    ${TIMEOUT}

    ${cnt_icon_tax}    Get Element Count    ${tbl_manage_invoice_list['cel_span_invoice_num_tax_icon']}

    Should Be Equal    "${cnt_icon_tax}"    "0"

Verify invoice staus show both invoice had tax invoice and not tax invoice
    [Documentation]    Verify invoice list show only number had Tax Invoice
                ...    Verify by invoice should be show in list

    Wait until loading complete 
    ${count}    Get Element Count    ${tbl_manage_invoice_list['row_all']}

    Run Keyword If    ${count}>int(0)    Comparation all row in invoice status equal filter with all invoice number
    ...    ELSE    Verify invoice status is empty

Comparation all row in invoice status equal filter with all invoice number 

    Element Should Be Visible     ${tbl_manage_invoice_list['row_all']}     

Verify invoice status is empty
    [Documentation]    Verify invoice not show any data in invoice status

    Wait until loading complete
    Page Should Contain Element           ${img_no_invoice_data}