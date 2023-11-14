*** Settings ***
Variables    ../../../resources/locators/invoice/invoice_locator.yaml

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
Filter invoice with status "${invoice_status}"
    Click drop down list for select status
    Click seleced status in drop down list panel    ${invoice_status}

User go to invoice page
    Click on 'Invoice' menu on left side
    Verify page 'Invoice' display

Search invoice number via input "${keyword_search}"
    Input value to "Keyword Search" text field    ${keyword_search}
    Click "Search" button

Go to invoice status detail page
    Click on first row from search result   

Search invoice on approve list by keyword equal "${keyword}" and invoice status equal "${invoice_status}" 
    Select invoice status on dropdown    ${invoice_status}
    Search invoice by search keyword    ${keyword}

Go to approve status detail page
    Click on first row from search result

Verify success bar show ${success_bar_msg} and web redirect to invoice list page
    Success bar for create invoice must be    ${success_bar_msg}
    Verify page 'Invoice' display   

Invoice '${inv_num}' status should be '${status}'
    Search invoice number via input "${inv_num}"
    Verify invoice list first row should have status      ${status}

User search invoice "${INVOICE_NUMBER_COMPLETE_RETENTION}" and status "${STATUS.COMPLETED_RETENTION}" which will be use to create invoice
    Select invoice status on dropdown    ${STATUS.COMPLETED_RETENTION}
    Search invoice by search keyword    ${INVOICE_NUMBER_COMPLETE_RETENTION}

User clicked at invoice "${INVOICE_NUMBER_COMPLETE_RETENTION}" to select invoice
    Click on first row from search result

User clicked "${invoice_action_button}" button
    Click invoice detail's view action button     ${invoice_action_button}
    Wait until loading complete 

Search filter is visible
    Verify page 'invoice' filter

Default filter should be 'Invoice Number' and status filter should be 'All Status'
    Check default value of filter    Invoice Number
    Check default value of status    All Status  

User clicked action button on row "${row_number}"
    Click action number on selected row    ${row_number}  

User choose invoice options "${action}" at row "${row_ number}"
    Choose invoice action from options list   ${action}    ${row_ number}

User click on specificed invoice row "${row_number}" at column "${column_no}" 
    Wait until loading complete
    Click on specificed row at specificed column     ${row_number}    ${column_no} 

User get invoice data for validate from invoice list invoice on row "${row_num}"  
    Get invoice num on selected row number    ${row_num}
    Get buyer name on selected row number    ${row_num}
    Get invoice create date on selected row number    ${row_num}

Selected invoice "${invoice_number_draft_status}" delete draft invoice should be deleted
    Wait until loading complete
    Success bar for create invoice must be      ${DELETE_INVOICE_SUCCESS_TXT.EN}
    Search invoice number via input "${invoice_number_draft_status}"
    Invoice list show "No result found"
    Invoice data should stamp data to deleted    ${invoice_number_draft_status}

Redirect to invoice list page with search invoice number "${invoice_number_draft_status}"  
    Wait until loading complete
    Success bar for create invoice must be      ${DELETE_INVOICE_SUCCESS_TXT.EN}
    Search invoice number via input "${invoice_number_draft_status}"
    Invoice list show "No result found"

Redirect from edit invoice to invoice list and show success bar "${message}" and status on row "${row_num}" should be "${invoice_status}"    
    Success bar should be    ${message}
    Invoice status on should be   ${row_num}    ${invoice_status}
    

Set draft invoice on invoice number "${invoice_number_draft_status}" to active
    Set Deleted flag invoice in db      0     ${invoice_number_draft_status}

Confirm delete
    Confirm delete modal display
    Click yes submit on confirm delete modal

User select status filter "${invoice_status}"
    Select invoice status on dropdown    ${invoice_status}

System should display all Invoice that have status "${invoice_status}"
    Verify status of invoice results     ${invoice_status}  

User click calendar in search textbox
    Click calendar button

Default calendar selection should be 'Any Time'
    Anytime radio button is selected

Select 'Created Date' date range
    Click 'Created Date' radio button

Selected calendar selection should be 'Created Date'
    Created Date radio button is selected

Select 'Due Date' date range
    Click 'Due Date' radio button

Selected calendar selection should be 'Due Date'
    Due Date radio button is selected
Invoice log "${action}" should be saved for selected invoice row "${row_number}" for invoice "${invoice_num}", buyer "${buyer}", create date "${create_date}"
    User clicked action button on row "${row_number}"
    Choose invoice action from options list   ${action}    ${row_number}
    Invoice history be show correctly on header with invoice number "${invoice_num}" and "${buyer}" and "${create_date}"
    Invoice history be show correctly on detail 

Work flow should be saved for invoice "${invoice_num}",supplier "${supplier_mpid}","${buyer_mpid}" status "${approval_status}" at sequence "${sequence}"
    ${db_result}    Get approve status and approval sequence    ${invoice_num}    ${buyer_mpid}    ${supplier_mpid}

    Approval status should be    ${db_result}[0][0]    ${approval_status}
    Approval sequence should be    ${db_result}[0][1]    ${sequence}

Invoice elastic should be saved for invoice "${invoice_num}" on supplier "${supplier_mpid}" from endpoint "${endpoint}", uri "${uri}"

    ${response}    Get invoice from elastic search via portal api on invoice "${invoice_num}" from supplier "${supplier_mpid}" from endpoint "${endpoint}", uri "${uri}"  
    Invoice should be saved in elastic search    ${response}    ${invoice_num}

Click tab 'Invoice Status'  

   Click invoice status's tab menu
  
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

Click invoice status's tab menu
    Wait Until Element Is Visible    ${invoice_status_tab_menu['invoice_status']}    ${TIMEOUT}
    Click Element    ${invoice_status_tab_menu['invoice_status']}

#######
Get approve status and approval sequence
    [Arguments]    ${invoice_num}    ${buyer_mpid}    ${supplier_mpid}

    ${statement}    Prepare statement get approval status and seq approved    ${invoice_num}    ${buyer_mpid}    ${supplier_mpid}
    ${approval_result}    eInvoice Execute SELECT query string    ${statement}

    [Return]    ${approval_result}

Approval status should be
    [Arguments]    ${actual_status}    ${expected_status}

    Should Be Equal As Strings    ${actual_status}    ${expected_status}    message=Approve status same as expected

Approval sequence should be
    [Arguments]    ${actual_seq}    ${expected_req}

    Should Be Equal As Integers     ${actual_seq}    ${expected_req}    message=Approver sequence same as expected

Invoice should be saved in elastic search 
    [Arguments]    ${response}    ${invoice_num}   

    ${actual_invoice_num}    Get From Dictionary    ${response.json()}[0]    invoiceNum

    Should Be Equal As Strings    ${actual_invoice_num}    ${invoice_num}    

######


Click drop down list for select status
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice['search_invoice']['lbl_status']}    ${TIMEOUT}
    Click Element    ${obj_invoice['search_invoice']['lbl_status']} 

Click seleced status in drop down list panel    
    [Arguments]    ${invoice_status}

    ${target_status}    Replace Variables    ${obj_invoice['search_invoice']['ddl_status']}
    
    Wait Until Element Is Visible     ${target_status}     ${TIMEOUT}
    Click Element    ${target_status}
    Wait until loading complete

Click "Create Invoice" button
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice.invoice_status_section.btn_create_invoice}    ${TIMEOUT}
    Click Element    ${obj_invoice.invoice_status_section.btn_create_invoice}

Click "Select PR/PO" button
    Wait Until Element Is Visible    ${obj_invoice.invoice_status_section.btn_select_pr_po}    ${TIMEOUT}
    Click Element    ${obj_invoice.invoice_status_section.btn_select_pr_po}

Click "Please select buyer..." dropdown list
    Wait Until Element Is Visible    ${obj_invoice.create_invoice_popup.ddl_select_buyer}    ${TIMEOUT}
    Click Element    ${obj_invoice.create_invoice_popup.ddl_select_buyer}

Input value to "Buyer Search" text field
    [Arguments]   ${buyer_name}
    Wait Until Element Is Visible    ${obj_invoice.create_invoice_popup.txt_search_buyer}    ${TIMEOUT}
    Input Text    ${obj_invoice.create_invoice_popup.txt_search_buyer}    ${buyer_name}

Click on first row of PO to see invoice details
    Wait Until Element Is Visible    ${obj_invoice.create_invoice_popup.ddl_select_buyer_item_1}    ${TIMEOUT}
    Click Element    ${obj_invoice.create_invoice_popup.ddl_select_buyer_item_1}

Click "Next" button to "Create Invoice"
    Wait Until Element Is Visible    ${obj_invoice.create_invoice_popup.btn_continue}    ${TIMEOUT}
    Click Element    ${obj_invoice.create_invoice_popup.btn_continue}    

Input value to "Keyword Search" text field
    [Arguments]    ${invoice_keyword_search}
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice.search_invoice.txt_search_invoice}    ${TIMEOUT}

    Input Text    ${obj_invoice.search_invoice.txt_search_invoice}    ${invoice_keyword_search}    

Click "Search" button

    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice.search_invoice.btn_search}    ${TIMEOUT}

    Click Element    ${obj_invoice.search_invoice.btn_search}

Click on the first row of Invoice Number in invoice list 
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice.invoice_list.tbl_first_row}    ${TIMEOUT}

    Click Element    ${obj_invoice.invoice_list.tbl_first_row}                   
    Click Element    ${obj_invoice.create_invoice_popup.btn_continue}

Click on 'Invoice' menu on left side
    Wait until loading complete
    Wait Until Element Is Visible   ${obj_invoice.right_menu.lnk_invoice_menu}       ${TIMEOUT}
    
    Click Element    ${obj_invoice.right_menu.lnk_invoice_menu}
    Wait until loading complete

Click on first row from search result    
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_invoice.invoice_list.tbl_first_row}    ${TIMEOUT}
    Click Element    ${obj_invoice.invoice_list.tbl_first_row}

Verify page 'Invoice' display
    Wait Until Element Is Visible    ${obj_invoice.invoice_status_section.btn_create_invoice_label}    ${TIMEOUT}


Select invoice status on dropdown
    [Arguments]    ${keyword_search}    
    Wait Until Element Is Visible    ${ddl_buyer_status_search_invoice_status_locator}    ${TIMEOUT}
    Wait until loading complete
    Click Element    ${ddl_buyer_status_search_invoice_status_locator}
    ${ddl_buyer_status_search_invoice_in_status_locator}=    Replace String    ${ddl_buyer_status_search_invoice_in_status_locator}    REPLACE_ME    \"${keyword_search}\"
    Wait Until Element Is Visible    ${ddl_buyer_status_search_invoice_in_status_locator}    ${TIMEOUT}
    Click Element    ${ddl_buyer_status_search_invoice_in_status_locator}
    Wait until loading complete   

Search invoice by search keyword
    [Arguments]    ${keyword_search}
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${txt_input_criteria_buyer_manage_invoice}     ${timeout}
    ...     AND     clear element text  ${txt_input_criteria_buyer_manage_invoice}
    ...     AND     Input Text    ${txt_input_criteria_buyer_manage_invoice}    ${keyword_search}
    ...     AND     Click Element    ${btn_search_button_buyer_manage_invoice}
    ...     AND     Wait until loading complete
    Log     ${keyword_search}     

Success bar for create invoice must be   
    [Arguments]  ${msg}
    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    ${actual_successbar}    Get Text     ${lbl_success_bar}   
    Should Contain Any    ${msg}    ${actual_successbar}

Success bar should be 
    [Arguments]    ${message}      

    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    ${actual_successbar}    Get Text     ${lbl_success_bar}   
    Should Contain Any    ${message}    ${actual_successbar}  
 
Verify invoice list first row should have status      
    [Arguments]     ${status}
    ${row}=     set variable    1
    ${status_locator}=  Replace variables   ${obj_invoice.invoice_list.lbl_firstrow_data_status}
    Wait Until Element Is Visible    ${status_locator}    ${TIMEOUT}
    Element text should be      ${status_locator}   ${status}

Click invoice detail's view action button 
    [Arguments]    ${invoice_action_button}
    ${target_obj}=    Replace Variables     ${obj_view_invoice_detail.btn_action}
    Wait Until Element Is Visible    ${target_obj}    ${TIMEOUT}
    Click Element    ${target_obj}

Click action number on selected row
    [Arguments]    ${row_number}
    #Row start from 1, but index start from 0
    ${row_index}    Evaluate    ${row_number}-1
    ${target_action_row}    Replace Variables    ${btn_action}

    Wait until loading complete
    Wait Until Element Is Visible    ${target_action_row}    ${TIMEOUT}
    Click Element    ${target_action_row}

Choose invoice action from options list  
    [Arguments]    ${action}    ${row_number}

    ${row_num}    Evaluate    ${row_number}-1

    ${target_cel}    Replace Variables    ${action_invoice['history']}
    Wait until loading complete
    Wait Until Element Is Visible     ${target_cel}
    Click Element    ${target_cel}

Click on specificed row at specificed column
    [Arguments]    ${row_number}    ${ret_col_no}
    
    ${invoice_row}    Replace Variables    ${obj_invoice.invoice_list.tbl_selectrow_on_column}
    Wait until loading complete
    Wait Until Element Is Visible    ${invoice_row}    ${TIMEOUT}
    Click Element    ${invoice_row}    

Get invoice num on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_invoice_list['col_invoice_num']}
    Wait until loading complete
    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_invoice_num}    Get Text    ${target_cel}

    Set Test Variable    ${TV_invoice_num}


Get buyer name on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_invoice_list['col_buyer']}
    Wait until loading complete
    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_buyer_name}    Get Text    ${target_cel}

    Set Test Variable    ${TV_buyer_name}

Get invoice create date on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_invoice_list['col_create_date']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_invoice_create_date}    Get Text    ${target_cel}

    Set Test Variable    ${TV_invoice_create_date}

Click on action button at row
    [Arguments]     ${row}
    ${action_with_row}      Replace Variables    ${obj_invoice.invoice_list.btn_action_with_row}
    Element should be visible        ${action_with_row}
    Click Element    ${action_with_row}  

Confirm delete modal display
    Wait Until Element Is Visible    ${obj_invoice.invoice_list.mdl_confirm_delete}   ${TIMEOUT}

Click yes submit on confirm delete modal
    Click Element    ${obj_invoice.invoice_list.btn_confirm_delete}

Invoice list show "No result found"
    Wait Until Element Is Visible    ${obj_invoice.invoice_list.txt_no_result_found}   ${TIMEOUT}

Invoice data should stamp data to deleted
    [Arguments]     ${invoice_number_draft_status}
    ${delete_flag}     Get Deleted flag invoice in db      ${invoice_number_draft_status}
    Should be equal     ${delete_flag}      ${TRUE}   

Verify page 'invoice' filter
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.btn_search}    ${TIMEOUT}
    
Check default value of filter
    [Arguments]   ${invoice_filter}
    ${target_obj}=    Replace Variables     ${obj_invoice.search_invoice.lbl_filter}  #${invoice_filter}

Check default value of status
    [Arguments]   ${invoice_status}
    ${target_obj}=    Replace Variables     ${obj_invoice.search_invoice.lbl_status}  #${invoice_status}

Verify status of invoice results 
    [Arguments]   ${invoice_status}
    ${results_exist}=    Run Keyword And Return Status    Page Should Contain Element    ${obj_invoice.invoice_list.tbl_result_row}
    @{list}=   Get Dictionary values   ${STATUS}
    Run Keyword if    ${results_exist}    Run Keywords    Remove Values From List     ${list}     ${invoice_status}
    ...    AND    Verify Results    ${list}
    ...    ELSE        Page Should Contain Element    ${obj_invoice.invoice_list.tbl_result_empty}

Verify Results
    [Arguments]   ${list}
    FOR    ${element}    IN    @{list}
        Element Should Not Contain    ${obj_invoice.invoice_list.tbl_result_row}   ${element}
    END

Click calendar button
    Click Element       ${obj_invoice.search_invoice.btn_calendar} 

Anytime radio button is selected
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_buyer_anytime}    ${TIMEOUT}
    Element Attribute Value Should Be    ${obj_invoice.search_invoice.rdo_buyer_anytime}    checked    true

Click 'Created Date' radio button
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_buyer_date_range}    ${TIMEOUT}
    Click Element       ${obj_invoice.search_invoice.rdo_buyer_date_range} 

Created Date radio button is selected
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_buyer_date_range}    ${TIMEOUT}
    Element Attribute Value Should Be    ${obj_invoice.search_invoice.rdo_buyer_date_range}    checked    true

Click 'Due Date' radio button
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_buyer_date_range}    ${TIMEOUT}
    Click Element       ${obj_invoice.search_invoice.rdo_buyer_date_range} 

Due Date radio button is selected
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_buyer_date_range}    ${TIMEOUT}
    Element Attribute Value Should Be    ${obj_invoice.search_invoice.rdo_buyer_date_range}    checked    true
Invoice status on should be
    [Arguments]    ${row_num}   ${invoice_status}
    [Documentation]    Verify invoice status in table list at first row only
    
    Wait until loading complete
    ${actual_status}    Get invoice status    ${row_num}
    Should Be Equal As Strings    ${actual_status}    ${invoice_status}
    

Get invoice status
    [Arguments]    ${row_num} 

    ${target_cel}    Replace Variables    ${tbl_invoice_list['col_status_label']}
    Wait until loading complete 
    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    Sleep    2s
    ${txt_status}    Get Text    ${target_cel}

    [Return]     ${txt_status}  



    
