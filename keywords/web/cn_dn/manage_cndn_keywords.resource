*** Settings ***
Variables    ../../../resources/locators/cn_dn/manage_cndn_locator.yaml
Variables    ../../../resources/locators/cn_dn/buyer_cndn_list_locator.yaml

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

Go to menu manage CN/DN
    Wait until loading complete
    manage_cndn_keywords.Click on 'CN/DN' menu on left side
    Click on manage CN/DN menu
    manage_cndn_keywords.Verify page 'CN/DN' display

Click first row of CN/DN at column "${column_name}"
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

Result table display CN/DN with "${cndn_status}"
    Result table display data and has only target status    ${cndn_status}

Result table display "${cndn_status}" status item sorting by 'Create Date' as DESC
    ${db_results}=  Get result in DB for status    ${cndn_status}
    Result table data should be equal to DB data    ${db_results}

Click icon 'tax filter' in column 'CN/DN Number'
    Click on 'tax filter' in column 'CN/DN Number'
    'Tax Invoice' list display

Select "${item_name}" in dropdown list
    Click on item in 'Tax Invoice' list    ${item_name}    

Get target CN/DN No. at column "${column_name}" at row "${row_num}" 
    Table CN/DN should have at least one row
    ${cndn_locator}=    Replace variables   ${obj_table.lbl_cndn_num}
    ${cndn_no}=     Get Text    ${cndn_locator}
    Set Test Variable    ${cndn_no}

Result table display field name "${cost_center_text}"
    Field 'Cost Center' display    ${cost_center_text}

Search CN/DN by CN/DN Number "${CNDNNum}"
     manage_cndn_keywords.Search CN/DN with search keyword    ${CNDNNum}    

Click expand CN/DN for first row
    Click on expand arrow on first row of table 'Manage CN/DN' 

'Buyer Referance' number "${buyer_ref}" is display in column "${column_name}"
    ${column_number}=  Get column number by target column name    ${column_name}    ${obj_table.tbl_cndn_result_header_row}
    ${column_number}=    Evaluate    ${column_number} + 1
    First row contain target data    ${buyer_ref}    ${column_number}

'Buyer Referance' number "${buyer_ref}" is display next to 'Referance Number' in CN/DN expansion
    Buyer referance display in first expansion row of 'CN/DN'    ${buyer_ref}      

CN/DN expansion display fields "${ref_no}", "${invoice_number}", "${po_number}", "${gr_number}", "${cost_center}", "${no}" and "${item_name}"
    First row expansion contain target field    ${ref_no}
    First row expansion contain target field    ${invoice_number}
    First row expansion contain target field    ${gr_number}
    First row expansion contain target field    ${cost_center}
    First row expansion contain target field    ${no}
    First row expansion contain target field    ${item_name} 

There is icon 'Tax Invoice' in column 'CN/DN Number'   
    There is icon 'Tax Invoice' in column 'CN/DN Number' For First Row         

Verify fields expansion CN/DN should show all detail correctly
    Verify first row in table fields expansion CN/DN should show all detail correctly      

Table display top 20 results 'With Tax Invoice' match with DB
    ${db_results}=  Get CNDN list result in DB for 'With Tax Invoice'
    Result table CNDN List 'With Tax Invoice' data should be equal to DB data    ${db_results}

Table display top 20 results 'No Tax Invoice' match with DB
    ${db_results}=  Get CNDN list result in DB for 'No Tax Invoice'
    Result table CNDN List 'No Tax Invoice' data should be equal to DB data    ${db_results}

There are "${all_status}", "${with_tax_invoice}", "${no_tax_invoice}" in dropdown list
    'Tax Invoice' list has choice    ${all_status}
    'Tax Invoice' list has choice    ${with_tax_invoice}
    'Tax Invoice' list has choice    ${no_tax_invoice}    

User select CN/DN with status "${cndn_status}"
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    ${cndn_status}
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with Supplier name "${suppliername}" and status '${MStatus}'
    Click 'filter' dropdown list
    Click on target filter     Supplier
    input search keyword    ${suppliername}
    Click search button
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    ${MStatus}
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

user select CN/DN with Buyer name "${BUYER_NAME}" and status "${MStatus}"
    Click 'filter' dropdown list
    Click on target filter     Buyer
    input search keyword    ${BUYER_NAME}
    Click search button
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    ${MStatus}

Search filter is visible
    Verify page 'CN/DN' filter

Default filter should be 'CN/DN' and status filter should be 'All Status'
    Check default value of filter    CN/DN
    Check default value of status    All Status

User select status filter "${cndn_status}"
    Click 'Status' dropdown list
    Click on target status    ${cndn_status} 
     
System should display all CN/DN that have status "${cndn_status}" 
    Table CN/DN should have at least one row
    Verify status of CN/DNs results    ${cndn_status}

User select CN/DN search filter and enter CN/DN number "${cndn_number}" in search textbox
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.FILTER_CNDN_NUMBER}
    input search keyword    ${cndn_number}
    Click search button

User select Invoice Number​ filter and enter Invoice Number​ "${invoice_number}" in search textbox
    Click 'filter' dropdown list
    Click on target filter     ${TEXT.INVOICE_NUMBER}
    input search keyword    ${invoice_number}
    Click search button

User select Reference Number​ filter and enter Reference Number​ "${reference_number}" in search textbox
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.REF_NO}
    input search keyword    ${reference_number}
    Click search button

User select Buyer filter and enter Buyer​ name "${NAME}" in search textbox
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.BUYER}
    input search keyword    ${name}
    Click search button

User select Supplier​ filter and enter Supplier​ name "${SUPPLIER​_NAME}" in search textbox
    Click 'filter' dropdown list
    Click on target filter     ${TEXT.SUPPLIER}
    input search keyword    ${supplier​_name}
    Click search button

System should display all CN/DN that have CN/DN Number "${cndn_number}"
    Table CN/DN should have at least one row
    Verify filtered CN/DN results    ${TEXT.CNDN_NUMBER}     ${cndn_number}

System should display all CN/DN that have Invoice Number​ "${invoice_number}"
    Verify filtered CN/DN results    ${TEXT.INVOICE_NUMBER}     ${INVOICE_NUMBER}
    
System should display all CN/DN that have Reference Number​ "${reference_number}"
    Verify filtered CN/DN results    ${TEXT.REF_NO}     ${REFERENCE_NUMBER}
    
System should display all CN/DN that have Buyer​ name "${NAME}"
    Verify filtered CN/DN results    ${TEXT.BUYER}     ${NAME}
    
System should display all CN/DN that have Supplier​ name "${SUPPLIER_NAME}"
    Verify filtered CN/DN results    ${TEXT.SUPPLIER}     ${SUPPLIER_NAME}
    
User click calendar in search textbox
    Click calendar button

Select 'Any time' date range
    Click 'Any time' radio button

Select 'Created Date' date range
    Click 'Created Date' radio button

Default calendar selection should be 'Any Time'
    Anytime radio button is selected

User select from date "${cndn_from_date}" and to date "${cndn_to_date}"
    Select from date   ${cndn_from_date}
    Select to date   ${cndn_to_date} 
    
System should display all CN/DN with status "${cndn_status}" and Created Date from date "${cndn_from_date}" and to date "${cndn_to_date}"
    Verify status of CN/DNs results    ${cndn_status}
    Table CN/DN should have at least one row
    Verify Created Date of CN/DNs results    ${cndn_from_date}     ${cndn_to_date}    ${cndn_status}  

'Invalid date' message should be appear at to date selector
    Check date alert message
     
System should display 'No results found.'
    'No results found' message is visible

Click first row of 'Manage CN/DN'    
    Click first row of 'Manage CN/DN' table
    Wait until loading complete   

User select action button of any CN/DN that status is Awaiting Approval
    Click 'Status' dropdown list
    Click on target status    Awaiting Approval
    Click on action button

User select action button of any CN/DN that status is Rejected
    Click 'Status' dropdown list
    Click on target status    Rejected
    Click on action button

User select any CN/DN that status is Rejected
    Click 'Status' dropdown list
    Click on target status    Rejected
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

System should display SAP details of "${CNDN_NUMBER_SAP}"
    Collect SAP Data from api and compare data form DB and UI    ${CNDN_NUMBER_SAP}

Click print billing
    Click print billing button

Browser should open new tab with print preview of Billing Statement
    Verify if Browser is open new tab

Print billing button should not visible
    Verify availability of Print billing button

User select any CN/DN that status is Awaiting Approval
    Click 'Status' dropdown list
    Click on target status    Awaiting Approval
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

Print billing​ button​, history button should be available
    Print billing button is available
    History button is available

Return document button​, history button should be available
    Return Document button is available

Cancel cndn button, print billing​ button​, history button should be available
    Cancel cn/dn button is available
    Print billing button is available
    History button is available

History button should be available
    History button is available

History button should not be available
    History button is not available

Cancel cn/dn should be available
    Cancel cn/dn button is available

Return document​ button should be available
    Return Document button is available

Print billing button should be available
    Print billing button is available

Print billing button, history button should be available on view cndn page
    Print billing button is available on view cndn page
    History button is available on view cndn page
    Number of action on top bar should be   2

Return document button, history button should be available on view cndn page
    Return Document button is available on view cndn page
    Number of action on top bar should be   2

Cancel cndn button, print billing button, history button should be available on view cndn page
    Cancel cn/dn button is available on view cndn page
    Print billing button is available on view cndn page
    History button is available on view cndn page
    Number of action on top bar should be   3

History button should not be available on view cndn page
    Verify history button invisibility on view cndn page

History button should be available on view cndn page
    History button is available on view cndn page
    Number of action on top bar should be   1

Cancel cn/dn should be available on view cndn page
    Cancel cn/dn button is available on view cndn page
    Number of action on top bar should be   1

Return document button should be available on view cndn page
    Return Document button is available on view cndn page
    Number of action on top bar should be   1

Print billing button should be available on view cndn page
    Print billing button is available on view cndn page     
    Number of action on top bar should be   1

Go to "view credit/debit note detail" at specifice credit/debit note "${cndn_number}" on column "${column_name}" 
    [Documentation]    Go to View Credit/Debit Note Detail on specific CNDN Number
                ...    CNDN Number not fixed but get from Manage Credit/Debit Note list page. 

    Search CN/DN with search keyword    ${cndn_number}
    Click on specificed row of credit/debit note table      ${cndn_number}    ${column_name}

Click menu history on specifice credit/debit note number "${cndn_number}"
    [Documentation]    Click action "History" at Manage Credit/Debit Note list
                ...    Can input full cn/dn number or part of cn/dn number
 
    #Search credit/debit note with search keyword    ${cndn_number}
    Search CN/DN with search keyword    ${cndn_number}
    Click action three dot on specific row    ${cndn_number}
    Click action "History" at manage credit/debit note list    

Set configuration of "${action_button}" button that have buyer "${BUYERMPID}" to be available at status "${cndn_status}"
    Set button configuration available   ${action_button}    ${buyermpid}    ${cndn_status}

Set configuration of "${action_button}" button that have buyer "${BUYERMPID}" to be disable at status "${cndn_status}"
    Set button configuration disable    ${action_button}    ${buyermpid}    ${cndn_status}

User search CNDN "${cndn_num}" which has information icon 
    Search CN/DN with search keyword    ${cndn_num}

User select CNDN "${cndn_num}" 
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}    

user clicked at CNDN which has information icon first row 
    Click on first row of 'CN/DN' which has information icon

User get credit/debit note data for validate from invoice list invoice on row "${row_num}"  
    Get cndn num on selected row number    ${row_num}
    Get buyer name on selected row number    ${row_num}
    Get cndn create date on selected row number    ${row_num}
User clicked action three dot button on row "${row_number}"
    Click three dot action number on selected row    ${row_number} 

User choose cndn options "${action}" at row "${row_number}"
    Choose cndn action from clik options three dot list    ${action}    ${row_number}

User click on specificed cndn row "${row_number}" at column "${column_no}" 
    Wait until loading complete
    Click on specificed row at specificed column     ${row_number}    ${column_no}    

Buyer user choose filter tax invoice condition 'With Tax Invoice' in cndn status
    Click icon filter tax invoice
    Choose filter tax invoice condition 'With Tax Invoice'

Buyer user choose filter tax invoice condition 'No Tax Invoice' in cndn status
    Click icon filter tax invoice
    Choose filter tax invoice condition 'No Tax Invoice'    

Buyer user choose filter tax invoice condition 'All CN/DN' in cndn status
    Click icon filter tax invoice
    Choose filter tax invoice condition 'No Tax Invoice'    

CNDN data show only cndn had 'Tax Invoice' in cndn status
    Verify cndn status show only cndn had tax invoice number

CNDN data show cndn had 'No Tax Invoice' in cndn status
    Verify cndn status not show cndn had tax invoice number 

CNDN data show both cndn had 'Tax Invoice' and 'No Tax Invoice' in cndn status    
    Verify cndn staus show both cndn had tax invoice and not tax invoice 
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
Click on specificed row at specificed column
    [Arguments]    ${row_number}    ${ret_col_no}

    ${invoice_row}    Replace Variables    ${select_row_col}
    Wait until loading complete
    Wait Until Element Is Visible    ${invoice_row}    ${TIMEOUT}
    Click Element    ${invoice_row}

Choose cndn action from clik options three dot list  
    [Arguments]    ${action}    ${row_number}

    ${specific_rows}    Evaluate    ${row_number}

    ${target_cel}    Replace Variables    ${btn_action['history']} 
    Wait until loading complete
    Wait Until Element Is Visible     ${target_cel}
    Click Element    ${target_cel}  

Click three dot action number on selected row
    [Arguments]    ${row_number}
    #Row start from 1, but index start from 0
    ${specific_rows}    Evaluate    ${row_number}
    ${target_action_row}    Replace Variables    ${btn_row_select_action}
    
    Wait until loading complete
    Wait Until Element Is Visible    ${target_action_row}    ${TIMEOUT}
    Click Element    ${target_action_row} 

Get cndn num on selected row number
    [Arguments]    ${row_num}

    Wait until loading complete
    ${target_cel}    Replace Variables    ${tbl_cndn_list['col_cndn_num']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_cndn_num}    Get Text    ${target_cel}

    Set Test Variable    ${TV_cndn_num}

Get buyer name on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables     ${tbl_cndn_list['col_buyer']}
    Wait until loading complete
    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_buyer_name}    Get Text    ${target_cel}

    Set Test Variable    ${TV_buyer_name}

Get cndn create date on selected row number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables     ${tbl_cndn_list['col_create_date']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_cndn_create_date}    Get Text    ${target_cel}

    Set Test Variable    ${TV_cndn_create_date}   


Select 'Manage CN/DN'
    Click Element    ${obj_manage_cndn.right_menu.lnk_manage_cndn_menu}
    Wait until loading complete   

Click on 'CN/DN' menu on left side
    Wait Until Element Is Visible         ${obj_cndn_status.right_menu.lnk_cndn_menu}    ${TIMEOUT}
    Click Element    ${obj_cndn_status.right_menu.lnk_cndn_menu}

Click on manage CN/DN menu
    Wait Until Element Is Visible         ${obj_cndn_status.right_menu.lnk_manage_cndn_menu}    ${TIMEOUT}
    Click Element    ${obj_cndn_status.right_menu.lnk_manage_cndn_menu}
    
Verify page 'CN/DN' display
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.tab_approve_cndn}    ${TIMEOUT}

Table CN/DN should have at least one row
    ${row_count}=    Get Element Count    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_row}
    Should Be True    ${row_count} > 0

Click on first row of 'CN/DN' which has information icon
    Wait Until Element Is Visible         ${obj_view_cndn.lbl_information_need_firstrow}    ${TIMEOUT}
    Click Element    ${obj_view_cndn.lbl_information_need_firstrow}

Click on first row of 'CN/DN' table
    [Arguments]    ${column_name}
    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_table.tbl_cndn_result_header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    ${target_obj}=    Replace Variables     ${obj_table.tbl_cndn_firstrow_data_with_columm}  
    Click Element    ${target_obj}

Click first row of 'Manage CN/DN' table
    Click Element    ${obj_table.firstrow}

Click 'Status' dropdown list
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.ddl_buyer_cndn_status}   ${TIMEOUT} 
    Click Element    ${obj_cndn_status.cndn_status_section.ddl_buyer_cndn_status}

Click 'filter' dropdown list
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}   ${TIMEOUT} 
    Click Element    ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}

Click on target status
    [Arguments]   ${cndn_status}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.lbl_buyer_cndn_status}  #${cndn_status}
    Wait Until Element Is Visible    ${target_obj}   ${TIMEOUT}
    Click Element    ${target_obj}
    Wait until loading complete

Result table display data and has only target status    
    [Arguments]    ${cndn_status} 
    Table CN/DN should have at least one row
    Verify 'CN/DN' at column display value correctly    Status      ${cndn_status} 

Get result in DB for status    
    [Arguments]     ${cndn_status}
    ${return_group_user_list}=    Query value 'GroupUser' in DB    '${TRUE_VERIFY_03}'  '${TRUE_MPID}'
    ${group_user_list}=     Convert list to string with quote separate by comma    ${return_group_user_list}
    ${return_condition_list}=   Query value 'ConditionUser' in DB   ${group_user_list}  '${TRUE_MPID}' 
    ${condition_list}=     Convert list to string with quote separate by comma    ${return_condition_list}
    ${sql_list_with_status}=  Get query string for SELECT 'CNDN' where with 'Condition' and 'Status'  ${condition_list}   ${cndn_status}
    ${return_cndn_list}=  eInvoice Execute SELECT query string    ${sql_list_with_status} 
    [Return]   ${return_cndn_list}

Result table data should be equal to DB data    
    [Arguments]    ${db_results} 
    ${Frontend_list}=   Set CNDN list from frontend to list
    ${DB_list}=     Set CNDN list db results to list   ${db_results}
    Lists Should Be Equal   ${Frontend_list}      ${DB_list}    ignore_order=True   

Click on action button
    Click Element    ${obj_cndn_status.cndn_action_menu.btn_action_menu}

Click print billing button
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}   ${TIMEOUT}
    Click Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}

Verify if Browser is open new tab 
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    Switch Window    NEW
    ${windows}=    Get Window Handles
    ${numWindows}=    Get Length  ${windows}
    Should Be True    ${numWindows} > 1

Print billing button is available
    Page Should Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}

Return Document button is available
    Page Should Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_return_document}

History button is available
    Page Should Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_history}

History button is not available
    Page Should Not Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_history}

Cancel cn/dn button is available
    Page Should Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_cancel}

Print billing button is available on view cndn page
    Page Should Contain Element    ${obj_cndn_status.cndn_manage_view_action_menu.btn_cndn_print_billing}

Return Document button is available on view cndn page
    Page Should Contain Element    ${obj_cndn_status.cndn_manage_view_action_menu.btn_cndn_return_document}

History button is available on view cndn page
    Page Should Contain Element    ${obj_cndn_status.cndn_manage_view_action_menu.btn_cndn_history}

Cancel cn/dn button is available on view cndn page
    Page Should Contain Element    ${obj_cndn_status.cndn_manage_view_action_menu.btn_cndn_cancel}    

Verify availability of Print billing button
    Page Should Not Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}

Verify history button invisibility on view cndn page
    Page Should Not Contain Element     ${obj_cndn_status.cndn_manage_view_action_menu.btn_cndn_history}    

Verify 'CN/DN' at column display value correctly
    [Arguments]     ${column}   ${value}
    ${row_count}=    Get Element Count    ${obj_table.tbl_cndn_buyer_result_row}
    ${ret_col_no}=    Get column number by target column name    ${column}    ${obj_table.header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable   ${ret_col_no}
    :FOR    ${row_number}    IN RANGE    1    ${row_count}
    \    Set Test Variable    ${row_number}
    \    ${row_target}=    Replace Variables in YAML file    ${obj_table.row_data_with_columm}
    \    ${actual}=    Get Text    ${row_target}
    \    Should Be Equal    ${value}    ${actual}  

Set CNDN list from frontend to list
    ${rowCount}     Get Element Count   ${obj_table.row_per_page}
    @{list}    Create List
     :FOR    ${i}    IN RANGE    0    ${rowCount}
    \   ${row_num}=   Set Variable    ${i+1}
    \   ${tbl_cell_CNDNNum}=        Replace Variables   ${obj_table.lbl_cndn_num}
    \   ${tbl_cell_Buyer}=          Replace Variables   ${obj_table.lbl_buyer} 
    \   ${tbl_cell_Supplier}=       Replace Variables   ${obj_table.lbl_supplier}
    \   ${tbl_cell_CreatedDate}=   Replace Variables   ${obj_table.lbl_createddate} 
    \   ${tbl_cell_Costcenter}=     Replace Variables   ${obj_table.lbl_costcenter}
    \   ${tbl_cell_NoteType}=       Replace Variables   ${obj_table.lbl_notetype}
    \   ${tbl_cell_IncludeVAT}=     Replace Variables   ${obj_table.lbl_includevat} 
    \   ${tbl_cell_Status}=         Replace Variables   ${obj_table.lbl_status}
    \   ${CNDNNum}=         Get Text    ${tbl_cell_CNDNNum}
    \   ${Buyer}=           Get Text    ${tbl_cell_Buyer}
    \   ${Supplier}=        Get Text    ${tbl_cell_Supplier}
    \   ${CreatedDate}=    Get Text    ${tbl_cell_CreatedDate}
    \   ${Costcenter}=      Get Text    ${tbl_cell_Costcenter}
    \   ${NoteType}=        Get Text    ${tbl_cell_NoteType}
    \   ${IncludeVAT}=      Get Text    ${tbl_cell_IncludeVAT}
    \   ${Status}=          Get Text    ${tbl_cell_Status}
    \   ${dictionary_value}=    Create Dictionary    CNDNNum=${CNDNNum}    Buyer=${Buyer}   Supplier=${Supplier}    CreatedDate=${CreatedDate}  CostCenter=${CostCenter}   NoteType=${NoteType}    IncludeVAT=${IncludeVAT}     Status=${Status}
    \   Append To List    ${list}    ${dictionary_value}
    [Return]    ${list}     

Set CNDN list db results to list    
    [Arguments]    ${db_results}
    ${rowCount}     Get Length   ${db_results}
    @{CNDNListdb}    Create List
    :FOR    ${i}    IN RANGE    0    ${rowCount}
    \   ${dictionary}=    Create Dictionary    CNDNNum=${db_results[${i}][0]}    Buyer=${db_results[${i}][2]}   Supplier=${db_results[${i}][3]}    CreatedDate=${db_results[${i}][4]}  CostCenter=${db_results[${i}][5]}   NoteType=${db_results[${i}][6]}    IncludeVAT=${db_results[${i}][7]}     Status=${db_results[${i}][8]}
    \   Append To List    ${CNDNListdb}    ${dictionary}
    [Return]   ${CNDNListdb}

Click on 'tax filter' in column 'CN/DN Number'
     Click element       ${btn_tax_invoice_filter}

Click on item in 'Tax Invoice' list    
    [Arguments]    ${item_name}  
    ${new_item_name}      Replace String      ${item_name}    ${space}    ${empty}
    Click element   ${ddl_tax_invoice_${new_item_name}}   

Get CN/DN number from expect row in table
    [Arguments]    ${column}    ${row_number}
    ${ret_col_no}=    Get column number by target column name    ${column}    ${obj_table.header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable   ${ret_col_no}
    Set Test Variable    ${row_number}
    ${target_obj}=    Replace Variables in YAML file        ${obj_table.row_data_with_columm}
    ${cndn_number}=    Get Text    ${target_obj}
    [Return]    ${cndn_number}    

Field 'Cost Center' display    
    [Arguments]    ${cost_center_text}    
    Element should contain      ${obj_table.tbl_cndn_result_header_text}     ${cost_center_text}

Search CN/DN with search keyword
    [Arguments]     ${keyword_search}
    Wait until loading complete
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${obj_search.txt_search}     ${timeout}
    ...     AND    clear element text  ${obj_search.txt_search} 
    ...     AND    Input Text    ${obj_search.txt_search}     ${keyword_search}
    ...     AND    Click Element    ${obj_search.btn_search}
    ...     AND    Wait until loading complete     

Click on expand arrow on first row of table 'Manage CN/DN'        
    ${row_num}      set variable    1
    ${btn_expand_locator}   Replace variables       ${obj_table.tbl_expand_button}  
    Mouse over      ${btn_expand_locator}
    Click element   ${btn_expand_locator}    

Buyer referance display in first expansion row of 'CN/DN'    
    [Arguments]    ${buyer_ref}   
    ${row_num}  set variable    1
    ${refno_locator}    Replace variables   ${obj_table.tbl_refno}
    ${Refno}    Get Text    ${refno_locator}
    @{Ref} =  Split String    ${Refno}      ${SPACE}
    Should be equal     ${Ref}[1]   (${buyer_ref})     

First row contain target data    
    [Arguments]    ${buyer_ref}    ${column_number}
    ${ret_col_no}   set variable    ${column_number}
    ${locator}=     Replace variables   ${obj_table.tbl_cndn_firstrow_data_with_columm}
    element should contain      ${locator}      (${buyer_ref})    

First row expansion contain target field    
    [Arguments]    ${text}
    ${row_num}  set variable   1
    ${expand_locator}   Replace variables   ${obj_table.tbl_expandsion_with_row}
    Element Should Contain      ${expand_locator}   ${text}    

There is icon 'Tax Invoice' in column 'CN/DN Number' For First Row
    ${row_num}  set variable    1
    ${locator_taxicon}      Replace variables   ${obj_table.lbl_cndn_num_w_taxicon}  
    Element should be visible       ${locator_taxicon}    

Verify first row in table fields expansion CN/DN should show all detail correctly
    ${cndn_id}=     Query CNDNID from 'CNDN' in DB      '${cndn_no}'
    Verify expansion 'Invoice Num' 'PO Num' 'GR Num'    ${cndn_id}
    Verify expansion PO Detail      ${cndn_id} 

Verify expansion 'Invoice Num' 'PO Num' 'GR Num'
    [Arguments]     ${cndn_id}
    ${sql_inv_po_gr}=           Get query string for SELECT 'CNDNItemDetail' where with 'CNDNID'    ${cndn_id}
    ${return_inv_po_gr_list}=   eInvoice Execute SELECT query string    ${sql_inv_po_gr}   
    ${target_inv}       Replace Variables    ${obj_table.tbl_inv_count}
    ${row_count}=       Get Element Count    ${target_inv}
    :FOR    ${inv_row_num}    IN RANGE    1    ${row_count}
    \    Set Test Variable    ${inv_row_num}
    \    ${db_row}=             Evaluate            ${inv_row_num}-1
    \    ${row_target_po}=      Replace Variables   ${obj_table.tbl_po_num}
    \    ${actual_po}=          Get Text            ${row_target_po}
    \    Should Be Equal        ${actual_po}        ${return_inv_po_gr_list[${db_row}][1]}
    \    ${row_target_gr}=      Replace Variables   ${obj_table.tbl_gr_num}
    \    ${actual_gr}=          Get Text            ${row_target_gr}
    \    Should Be Equal        ${actual_gr}        ${return_inv_po_gr_list[${db_row}][2]}
    # \    ${row_target_inv}=    Replace Variables    ${obj_table.tbl_inv_num}
    # \    ${actual_inv}=    Get Text    ${row_target_inv}   
    # \    Should Be Equal    ${actual_inv}    ${return_inv_po_gr_list[${db_row}][0]}


Verify expansion PO Detail    
    [Arguments]     ${cndn_id}    
    ${sql_detail_po}=       Get query string for SELECT 'CNDNItemDetail' where with 'CNDNID' for PO Detail    ${cndn_id}      # can reuse keyword from cndn db
    ${return_po_detail}=    eInvoice Execute SELECT query string    ${sql_detail_po}  
    ${row_num}=             Set variable    1      
    ${target_po_detail}     Replace Variables       ${obj_table.tbl_detail_count}
    ${row_count}=           Get Element Count       ${target_po_detail}
    :FOR    ${detail_row_num}    IN RANGE    1    ${row_count}
    \    Set Test Variable  ${detail_row_num}
    \    ${db_row}=         Evaluate                ${detail_row_num}-1
    \    ${row_target_no}=  Replace Variables       ${obj_table.tbl_no}
    \    ${actual_no}=      Get Text                ${row_target_no}
    \    Should Be Equal    ${actual_no}            ${return_po_detail[${db_row}][0]}${EMPTY}
    \    ${row_target_desc}=    Replace Variables   ${obj_table.tbl_Item_name}
    \    ${actual_desc}=    Get Text                ${row_target_desc}
    \    ${expect_desc}=    Replace String          ${return_po_detail[${db_row}][1]}    ${SPACE * 2}    ${SPACE}
    \    Should Be Equal    ${actual_desc}          ${expect_desc}

'Tax Invoice' list display
    Element should be visible      ${ddl_tax_invoice}

'Tax Invoice' list has choice    
    [Arguments]    ${tax_invoice_choice}
    Element Should Contain      ${ddl_tax_invoice}     ${tax_invoice_choice}        

Get CNDN list result in DB for 'With Tax Invoice'
    ${return_group_user_list}=    Query value 'GroupUser' in DB    '${TRUE_VERIFY_03}'  '${TRUE_MPID}'
    ${group_user_list}=     Convert list to string with quote separate by comma    ${return_group_user_list}
    ${return_condition_list}=   Query value 'ConditionUser' in DB   ${group_user_list}  '${TRUE_MPID}' 
    ${condition_list}=     Convert list to string with quote separate by comma    ${return_condition_list}
    ${sql_tax_invoice}=  Get query string for SELECT 'CNDN' where with 'Condition' and TaxInvoice is not null    ${condition_list}
    ${return_tax_invoice}=  eInvoice Execute SELECT query string    ${sql_tax_invoice} 
    [Return]   ${return_tax_invoice}

Result table CNDN list 'With Tax Invoice' data should be equal to DB data
    [Arguments]    ${db_results}
    ${Frontend_list}=   Set CNDN list from frontend to list
    ${DB_list}=     Set CNDN list db results to list  ${db_results}
    Lists Should Be Equal   ${Frontend_list}      ${DB_list}    ignore_order=True

Get CNDN list result in DB for 'No Tax Invoice'
    ${return_group_user_list}=    Query value 'GroupUser' in DB    '${TRUE_VERIFY_03}'  '${TRUE_MPID}'
    ${group_user_list}=     Convert list to string with quote separate by comma    ${return_group_user_list}
    ${return_condition_list}=   Query value 'ConditionUser' in DB   ${group_user_list}  '${TRUE_MPID}' 
    ${condition_list}=     Convert list to string with quote separate by comma    ${return_condition_list}
    ${sql_tax_invoice}=  Get query string for SELECT 'CNDN' where with 'Condition' and TaxInvoice is null     ${condition_list}
    ${return_tax_invoice}=  eInvoice Execute SELECT query string    ${sql_tax_invoice} 
    [Return]   ${return_tax_invoice}

Result table CNDN list 'No Tax Invoice' data should be equal to DB data
    [Arguments]    ${db_results}
    ${Frontend_list}=   Set CNDN list from frontend to list
    ${DB_list}=     Set CNDN list db results to list  ${db_results}
    Lists Should Be Equal   ${Frontend_list}      ${DB_list}    ignore_order=True

Click on target filter
    [Arguments]   ${cndn_filter}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_search_filter_section.lbl_cndn_filter}  #${cndn_filter}
    Wait Until Element Is Visible    ${target_obj}   ${TIMEOUT}
    Click Element    ${target_obj}

Input search keyword
    [Arguments]   ${buyer​_name}
    Input Text    ${obj_search.txt_search}    ${buyer​_name}

Click search button
    Click Element    ${obj_search.btn_search}

Verify page 'CN/DN' filter
    Wait Until Element Is Visible         ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}    ${TIMEOUT}

Check default value of filter
    [Arguments]   ${cndn_filter}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_search_filter_section.lbl_cndn_filter}  #${cndn_filter}
    
Check default value of status
    [Arguments]   ${cndn_status}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.lbl_buyer_cndn_status}  #${cndn_status}

Verify status of CN/DNs results 
    [Arguments]   ${cndn_status}
    @{list}=   Get Dictionary values   ${STATUS}
    Remove Values From List     ${list}     ${cndn_status}
    :FOR    ${element}    IN    @{list}
    \       Element Should Not Contain    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_row}   ${element}

Verify filtered CN/DN results
    [Arguments]   ${filter}   ${value}

    ${filter}=    Run Keyword If    '${filter}' == 'CN/DN Number'    Set Variable    cndnNum
              ...   ELSE IF    '${filter}' == 'Invoice Number'    Set Variable    invoiceNum
              ...   ELSE IF    '${filter}' == 'Reference No.'    Set Variable    groupNum
              ...   ELSE IF    '${filter}' == 'Buyer'    Set Variable    buyerName
              ...   ELSE IF    '${filter}' == 'Supplier'    Set Variable    supplierName

    ${auth}=    Get Cookie    buyer_auth
    &{cookies}=    Create Dictionary    app_type=EInvoiceBuyer    buyer_auth=${auth.value}   buyer_lang=en
    ${api}=     Set Variable    api/groupCndnByApprover
    ${param}=    Set Variable    buyerMpID=${BUYERMPID}&userID=${TRUE_VERIFY_03}&${filter}=${value}&conditionValue=MyCondition&statusID=&fromDueDate=&toDueDate=&fromCreateDate=&toCreateDate=&page=0&size=20&sort=&defaultSort=createdDate,desc&taxInvoiceFilter=all&fromDate=&toDate=
   
    Create session    test    http://uat-invoice-portal.oneplanets.com    cookies=${cookies}
    ${response}=     Get Request    test    ${api}?${param}
    ${json}=   Convert String to JSON    ${response.text}
    #Get results
    ${results}=    Run Keyword If    '${filter}' == 'cndnNum'    Get Value From Json    ${json}     $.content[*].cndnNum
              ...   ELSE IF    '${filter}' == 'invoiceNum'    Get Value From Json    ${json}    $.content[*].cndnItems[*].invoiceNum
              ...   ELSE IF    '${filter}' == 'groupNum'    Get Value From Json    ${json}     $.content[*].groupNum
              ...   ELSE IF    '${filter}' == 'buyerName'    Get Value From Json    ${json}     $.content[*].buyerName
              ...   ELSE IF    '${filter}' == 'supplierName'    Get Value From Json    ${json}     $.content[*].supplierName
    #Validate results
    Run Keyword If    '${filter}' == 'cndnNum'    Should Contain Match    ${results}    ${value}
              ...   ELSE IF    '${filter}' == 'invoiceNum'    Should Contain    ${results}    ${value}
              ...   ELSE IF    '${filter}' == 'groupNum'    Should Contain    ${results}    ${value}
              ...   ELSE IF    '${filter}' == 'buyerName'    Should Contain Match    ${results}    ${value}*
              ...   ELSE IF    '${filter}' == 'supplierName'    Should Contain Match    ${results}    ${value}

Click calendar button
    Click Element       ${obj_cndn_status.cndn_calendar_menu.btn_calendar}  

Anytime radio button is selected
    Element Attribute Value Should Be    ${obj_cndn_status.cndn_calendar_menu.rdo_anytime}    checked    true

Click 'Any time' radio button
    Click Element       ${obj_cndn_status.cndn_calendar_menu.rdo_anytime} 

Click 'Created Date' radio button
    Click Element       ${obj_cndn_status.cndn_calendar_menu.rdo_date_range} 

Select from date   
    [Arguments]    ${cndn_from_date}
    #Convert Date Format
    ${cndn_from_date}=    Convert Date    ${cndn_from_date}    result_format=%Y-%m-%d
    #Get month and year
    ${month_txt}=    Convert Date    ${cndn_from_date}    result_format=%B
    ${year_txt}=    Convert Date    ${cndn_from_date}    result_format=%Y

    Click Element       ${obj_cndn_status.cndn_calendar_menu.txt_date_from}

    #Select Month
    :FOR    ${i}    IN RANGE    999999
    \    ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_from_month_select}    ${month_txt}
    \    Exit For Loop If    ${month_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_month}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_month}
    #Select Year
    :FOR    ${i}    IN RANGE    999999
    \    ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_from_year_select}    ${year_txt}
    \    Exit For Loop If    ${year_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_year}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_year}
    #Select Date
    Execute Javascript    document.getElementById('rb-buyer-calendar-dateFrom').querySelector("td[title='${cndn_from_date}'] > div").click()
    

Select to date    
    [Arguments]    ${cndn_to_date}
    #Convert Date Format
    ${cndn_to_date}=    Convert Date    ${cndn_to_date}    result_format=%Y-%m-%d
    #Get month and year
    ${month_txt}=    Convert Date    ${cndn_to_date}    result_format=%B
    ${year_txt}=    Convert Date    ${cndn_to_date}    result_format=%Y

    Click Element       ${obj_cndn_status.cndn_calendar_menu.txt_date_to}

    #Select Month
    :FOR    ${i}    IN RANGE    999999
    \    ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_to_month_select}    ${month_txt}
    \    Exit For Loop If    ${month_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_month}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_month}
    #Select Year
    :FOR    ${i}    IN RANGE    999999
    \    ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_to_year_select}    ${year_txt}
    \    Exit For Loop If    ${year_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_year}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_year}
    #Select Date
    Execute Javascript    document.getElementById('rb-buyer-calendar-dateTo').querySelector("td[title='${cndn_to_date}'] > div").click()

Verify Created Date of CN/DNs results    
    [Arguments]    ${cndn_from_date}    ${cndn_to_date}    ${cndn_status}
    #Convert Date Format
    ${cndn_from_date}=    Convert Date    ${cndn_from_date}    result_format=%Y-%m-%d
    ${cndn_to_date}=    Convert Date    ${cndn_to_date}    result_format=%Y-%m-%d
    #Set status value
    ${cndn_status}=    Run Keyword If    '${cndn_status}' == 'Awaiting Approval'    Set Variable    1
              ...   ELSE IF    '${cndn_status}' == 'Pending'    Set Variable    2
              ...   ELSE IF    '${cndn_status}' == 'Completed'    Set Variable    3
              ...   ELSE IF    '${cndn_status}' == 'Rejected'    Set Variable    4
              ...   ELSE IF    '${cndn_status}' == 'Expired'    Set Variable    5
              ...   ELSE IF    '${cndn_status}' == 'Document Return'    Set Variable    6
              ...   ELSE IF    '${cndn_status}' == 'Cancelled'    Set Variable    7
              ...   ELSE    Set Variable    ''

    ${auth}=    Get Cookie    buyer_auth
    &{cookies}=    Create Dictionary    app_type=EInvoiceBuyer    buyer_auth=${auth.value}   buyer_lang=en
    ${api}=     Set Variable    api/groupCndnByApprover
    ${param}=    Set Variable    buyerMpID=${BUYERMPID}&userID=${TRUE_VERIFY_03}&conditionValue=MyCondition&statusID=${cndn_status}&fromDueDate=&toDueDate=&fromCreateDate=&toCreateDate=&page=0&size=20&sort=&defaultSort=createdDate,desc&taxInvoiceFilter=all&fromDate=${cndn_from_date}&toDate=${cndn_to_date}
   
    Create session    test    http://uat-invoice-portal.oneplanets.com    cookies=${cookies}
    ${response}=     Get Request    test    ${api}?${param}
    ${json}=   Convert String to JSON    ${response.text}

    ${results}=    Get Value From Json    ${json}     $.content[*].CreatedDate

    :FOR    ${element}    IN    @{results}
    \     ${element}=    Fetch From Left    ${element}    T
    \     ${element}=    Convert Date    ${element}    result_format=%Y-%m-%d
    #Validate date range
    \     Should be true    '${element}' >= '${cndn_from_date}'     
    \     Should be true    '${element}' <= '${cndn_to_date}'

Collect SAP Data from api and compare data form DB and UI    
    [Arguments]     ${CNDN_NUMBER}
    #Get SAP value from API
    ${auth}=    Get Cookie    buyer_auth
    &{cookies}=    Create Dictionary    app_type=EInvoiceBuyer    buyer_auth=${auth.value}   buyer_lang=en
    ${api}=     Set Variable    api/cndnUIItems
    ${param}=    Set Variable    buyerMpID=${BUYERMPID}&cndnID=${CNDN_ID}&showDefault=false
    Create session    test    http://uat-invoice-portal.oneplanets.com    cookies=${cookies}
    ${response}=     Get Request    test    ${api}?${param}
    ${json}=   Convert String to JSON    ${response.text}
    ${UI_item_ID}=    Get Value From Json    ${json}    $.cndnuiItemList[*].uiItemID
    ${UI_item_value}=    Get Value From Json    ${json}    $.cndnuiItemList[*].value
    &{API_value}=   Convert To Dictionary    ${empty}
    ${length}=     Get Length     ${UI_item_ID}
    :FOR   ${INDEX}    IN RANGE    ${length}
    \    ${item_id}=    Convert To String    @{UI_item_ID}[${INDEX}]
    \    Set To Dictionary     ${API_value}    ${item_id}=@{UI_item_value}[${INDEX}]
    #Get value from DB
    \    ${query_string}    CATENATE    
         ...    SELECT Value 
         ...    FROM CNDN_UIItemValue
         ...    WHERE BuyerMpID = '${BUYERMPID}' AND CNDNID = ${CNDN_ID} AND UIItemID = @{API_value}[${INDEX}]
    \    @{db_value}=    eInvoice Execute SELECT query string    ${query_string}
    #Check if there's any data in DB by verify query's result length   
    \    ${len}  Get Length   ${db_value}
    #Compare value
    \    ${key}=    Set Variable     @{API_value}[${INDEX}]
    \    Run Keyword Unless   ${len} == 0    Should Be Equal    ${db_value[0][0]}     &{API_value}[${key}]

Check date alert message
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_calendar_menu.alert_invalid_date}    ${TIMEOUT}

'No results found' message is visible
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.spn_no_results}    ${TIMEOUT}

Click on specificed row of credit/debit note table
    [Arguments]    ${find_keyword}=none    ${column_name}=none
    [Documentation]    Click on the specificed row number at credit/debit note table
    
    ${status}=    Run Keyword If    '${find_keyword}'!='none'    Run Keyword And Return Status
    ...                Find random row match contain keyword    ${find_keyword}

    Run Keyword If    '${status}'=='True'    Click on specific row of 'CN/DN' table    ${column_name}    ${row_no}
    ...    ELSE    Click on first row of 'CN/DN' table 
    Wait until loading complete

Click on specific row of 'CN/DN' table
    [Arguments]    ${column_name}    ${row_num}
    [Documentation]    Click the specific row in credit/debit note list
                ...    at select clumn-name

    ${column_target}=    Set Variable    ${column_name}
    ${specific_rows}    Set Variable    ${row_no}
    ${row_num}    Set Variable    ${row_no} 

    Set Test Variable    ${specific_rows}

    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    ${target_obj}=    Replace Variables    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_specific_with_columm}    #${ret_col_no}
    ${target_obe}=    Replace Variables    ${target_obj}

    Get credit/debit note number in table manage credit/debit note list

    Click Element    ${target_obj}  

Click action three dot on specific row    
    [Arguments]    ${find_keyword}=none
    [Documentation]    Click three dot button at Manage CN/DN List at the specific row
    
    ${status}=    Run Keyword If    '${find_keyword}'!='none'    Run Keyword And Return Status
    ...                Find random row match contain keyword    ${find_keyword}  

    Run Keyword If    '${status}'=='True'    Click action options three dot at specific rows   
    ...    ELSE    Click action options three dot at first row                  

Click action options three dot at specific rows    
    [Documentation]    Click options three dot at specific row

    ${specific_rows}    Set Variable    ${row_no}

    ${btn_row_select_action}    Replace Variables    ${btn_row_select_action}   

    Set Test Variable    ${specific_rows}

    Wait Until Element Is Visible     ${btn_row_select_action}

    Get credit/debit note number in table manage credit/debit note list

    Click Element     ${btn_row_select_action}

Click action options three dot at first row
    [Documentation]    Click options three dot at first row

    ${specific_rows}    Set Variable    1
    ${btn_row_select_action}    Replace Variables    ${btn_row_select_action}    

    Set Test Variable    ${specific_rows}

    Wait Until Element Is Visible    ${btn_row_select_action}    ${TIMEOUT}
  
    Get credit/debit note number in table manage credit/debit note list

    Click Element    ${btn_row_select_action}

Get credit/debit note number in table manage credit/debit note list   
    [Arguments]    ${row_num}=none
    [Documentation]    Get credit/debit note number from credit/debit note list
                ...    on specific row numer

    ${row_num}=    Set Variable If    
    ...    '${row_num}'=='none'    ${specific_rows}

    ${obj_table.lbl_cndn_num}    Replace Variables    ${obj_table.lbl_cndn_num}       

    Wait Until Element Is Visible    ${obj_table.lbl_cndn_num}
    ${var_cndn_number}    Get Text     ${obj_table.lbl_cndn_num}

    Set Test Variable       ${var_cndn_number}         

Find specific row on select data in column    
    [Arguments]    ${expected_text}
    [Documentation]    Find the table row that table row cell matching expected text         

    #initial row number variable value
    ${row_no}    Set Variable    0

    #get row count that display on ui
    ${end}=    Get Element Count    ${tbl_cndn_approval_list.row_per_page} 

    ${end}    Evaluate    ${end}+1
    ${start}    Set Variable    1    
    :FOR    ${index}    IN RANGE    ${start}    ${end}
        ${row}    Convert To String    ${index}
        ${selected_row}    Replace Variables    ${tbl_cndn_approval_list.row_specific_number}
        ${actual}    Get Text     ${selected_row}   
        ${is_equal}    Run Keyword And Return Status    Should Be Equal    ${expected_text}    ${actual}
        ${row_no}    Set Variable    ${index}

        Run Keyword If    '${is_equal}'=='True'    Exit For Loop
    END

    Set Test Variable    ${row_no}    
    Wait until loading complete   

Find random row match contain keyword
    [Arguments]    ${contain_keyword}=none
    [Documentation]    Find the random row that displayed on the UI

    #initial row number variable value
    ${row_no}    Set Variable    1 

    #get row count that display on ui
    ${end_idx}=    Get Element Count     ${obj_table.row_per_page}

    ${end}    Evaluate    ${end_idx}+1
    ${start}    Set Variable    1    

    #random integer keyword required two arguments. start number and end number
    # start row equal 1, and end_idx equal maximum row in page
    ${random_row}    Random integer    ${start}    ${end_idx}
    ${row_no}    Set Variable    ${random_row}

    #Retrun row number and can use in current test cases scope
    Set Test Variable    ${row_no}   

Find table row matching keyword
    [Arguments]    ${keyword}=none
    [Documentation]    Find the row that match expected keyword

    #initial row number variable value
    ${row_no}    Set Variable    1 

    #get row count that display on ui
    ${end_idx}=    Get Element Count     ${obj_table.row_per_page}

    ${end}    Evaluate    ${end_idx}+1
    #${start}    Set Variable    1    

    #loop for, find maching row equal expected keyword
    :FOR    ${index}    IN RANGE    ${start}    ${end}
        ${row_num}    Convert To String    ${index}
        ${selected_row}    Replace Variables    ${obj_table.tbl_rows}
        ${actual}    Get Text     ${selected_row}   
        ${is_equal}    Run Keyword And Return Status    Should Be Equal    ${actual}    ${keyword}
        ${matching_row_no}    Set Variable    ${index}

        Run Keyword If    '${is_equal}'=='True'    Exit For Loop
    END

    #Retrun row number and can use in current test cases scope
    Set Test Variable    ${matching_row_no}              

Click action "History" at manage credit/debit note list
    [Documentation]    Click action "History" option

    ${action_history_locator}    Replace Variables    ${action.history} 

    Wait Until Element Is Visible    ${action_history_locator}
    Click Element    ${action_history_locator} 
    Wait until loading complete      

Click on random row of 'CN/DN' table at selected column
    [Arguments]    ${column_name}

    #Find random row match contain keyword

    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_cndn_status.cndn_status_section.tbl_cndn_result_header_row}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.tbl_cndn_firstrow_with_columm}
    Click Element    ${target_obj}  

    Wait until loading complete      

Click action "History" at view manage credit/debit note page
    [Documentation]    Click action "History"

    Wait Until Element Is Visible    //*[@id="rb-modal-viewapproval-cndn"]//i[@class="icon-history"]         
    Click Element    //*[@id="rb-modal-viewapproval-cndn"]//i[@class="icon-history"] 

Set button configuration available
    [Arguments]    ${action_button}    ${buyermpid}    ${cndn_status}
    ${cndn_action_field}=    Get mapping action of CN/DN status code via status name    ${action_button}
    eInvoice Execute INSERT, UPDATE, DELETE query string    UPDATE CNDNStatus SET ${cndn_action_field} = 1 WHERE BuyerMpID = '${buyermpid}' AND CNDNStatus = '${cndn_status}' AND TypeID = 5
    eInvoice Execute INSERT, UPDATE, DELETE query string    UPDATE CNDNStatus SET ${cndn_action_field} = 1 WHERE BuyerMpID = '${buyermpid}' AND CNDNStatus = '${cndn_status}' AND TypeID = 6

Set button configuration disable
    [Arguments]    ${action_button}    ${buyermpid}    ${cndn_status}
    ${cndn_action_field}=    Get mapping action of CN/DN status code via status name    ${action_button}
    eInvoice Execute INSERT, UPDATE, DELETE query string    UPDATE CNDNStatus SET ${cndn_action_field} = 0 WHERE BuyerMpID = '${buyermpid}' AND CNDNStatus = '${cndn_status}' AND TypeID = 5
    eInvoice Execute INSERT, UPDATE, DELETE query string    UPDATE CNDNStatus SET ${cndn_action_field} = 0 WHERE BuyerMpID = '${buyermpid}' AND CNDNStatus = '${cndn_status}' AND TypeID = 6

Number of action on top bar should be
    [Arguments]    ${expect_action_no}
    ${actual_action_number}     Get Element Count   ${obj_cndn_status.cndn_manage_view_action_menu.action_on_top_bar}
    Should be equal as strings  ${expect_action_no}     ${actual_action_number}

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

Verify cndn status show only cndn had tax invoice number
    [Documentation]    Verify cndn list show only number had Tax Invoice
                ...    Verify by compare all data in list equal data had Tax Invoice

    Wait until loading complete
    Wait Until Element Is Visible    ${obj_table['firstrow']}    ${TIMEOUT}
    
    ${cnt_icon_tax}    Get Element Count    ${obj_table['cel_span_invoice_num_tax_icon']}   
    ${cnt_row_all}    Get Element Count    ${obj_table['row_per_page']} 

    Should Be Equal    ${cnt_icon_tax}    ${cnt_row_all}

Verify cndn status not show cndn had tax invoice number
    [Documentation]    Verify cndn list show only number had Tax Invoice
                ...    Verify by invoice had Tax Invoice equal zero

    Wait until loading complete
    Wait Until Element Is Visible    ${obj_table['firstrow']}    ${TIMEOUT}

    ${cnt_icon_tax}    Get Element Count    ${obj_table['cel_span_invoice_num_tax_icon']}

    Should Be Equal    "${cnt_icon_tax}"    "0"

Verify cndn staus show both cndn had tax invoice and not tax invoice
    [Documentation]    Verify cndn list show only number had Tax Invoice
                ...    Verify by invoice should be show in list

    Wait until loading complete 
    Element Should Be Visible     ${obj_table['row_per_page']}    