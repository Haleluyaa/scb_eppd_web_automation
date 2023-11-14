*** Settings ***
Variables    ../../../resources/locators/cn_dn/cndn_approve_locators.yaml

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
Go to menu Approve CN/DN
    Select 'Approve CN/DN'
    Verify page 'Approve CN/DN' display

Click first row of Approval CN/DN at column "${column_name}"
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${column_name}
    Wait until loading complete

Click first row of 'Approval CN/DN'
    Click first row of 'Approval CN/DN' table
    Wait until loading complete

Search Approval CN/DN with approval status "${cndn_status}"
    Click 'Status' dropdown list
    Click on target status    ${cndn_status}

Get target CN/DN No. at column "${column_name}" at row "${row_num}"
    Table CN/DN should have at least one row
    ${cndn_locator}=    Replace variables   ${obj_table.lbl_cndn_num}
    ${cndn_no}=     Get Text    ${cndn_locator}
    Set Test Variable    ${cndn_no}

Get target CN/DN Type at column "${column_name}" at row "${row_num}"
    Table CN/DN should have at least one row
    ${cndn_type}=  Get CN/DN type from expect row in table    ${column_name}    ${row_num}
    Set Test Variable    ${cndn_type}

Get target CN/DN Status at column "${column_name}" at row "${row_num}" and set variable 'original status'
    Table CN/DN should have at least one row
    ${cndn_status}=  Get CN/DN status from expect row in table    ${column_name}    ${row_num}
    Set Test Variable    ${original_status}     ${cndn_status}

Set value in DB for 'CN/DN approval status' as "${approval_status}"
    Update value to field 'CN/DN approval status' in DB    ${approval_status}    '${cndn_no}'    ${cndn_type}

Set value in DB for 'CN/DN status' as "${cndn_status}"
    Get target CN/DN Status and set variable 'original cndn status'
    Update value to field 'CN/DN status' in DB    ${cndn_status}    '${cndn_no}'     

Get target CN/DN Status and set variable 'original cndn status'     
    ${cndn_status}=  Get CN/DN status from 'CN/DN' table in DB    '${cndn_no}'
    Set Test Variable    ${original_cndn_status}     ${cndn_status}

Click menu history on "${invoice_number}"    
    Search invoice with search keyword    ${invoice_number}
    Click menu three dot at first row
    Click action "History"

Go to "View CNDN Detail" on specific invoice number "${invoice_number}" on column "${column_name}"       
    Search invoice with search keyword    ${invoice_number}
    Click on first row of 'CN/DN' table    ${column_name}

Search Approval CN/DN with status "${approval_status}"
    Click 'Approval Status' dropdown list
    Click on target Approval status    ${approval_status}

Action list should show '${action}' at row number '${row_number}'
    Verify action list show action correctly at specific row     ${action}   ${row_number}

Get 'Condition list' of approver, user login "${ep_username}" and "${site_mpid}"
    ${return_group_user_list}=    Query value 'GroupUser' in DB    '${ep_username}'  '${site_mpid}'
    ${group_user_list}=     Convert list to string with quote separate by comma    ${return_group_user_list}
    ${return_condition_list}=   Query value 'ConditionUser' in DB   ${group_user_list}  '${site_mpid}'
    Set Test Variable    ${condition_list}  ${return_condition_list}

Get 'Condition list' of approver, user login "${ep_username}" and "${site_mpid}" who dont have group user
    ${return_condition_list}=    Query value 'ConditionUser' in DB for user who does not have group    '${site_mpid}'
    Set Test Variable    ${condition_list}  ${return_condition_list}

Get total number of CNDN list with "${ep_username}" site '${site_mpid}' Type 'Verify document' and filter condition is 'All Cost Center'
     ${return_group_user}=    Query value 'GroupUser' in DB    '${ep_username}'  '${site_mpid}'
     ${sql_total}=  Get query string for SELECT Count 'CNDNApproval' where with 'Approver' , 'ApproverGroup' and ApprovalType is 'Verify Document'  ${ep_username}  ${return_group_user[0][0]}
     ${return_total_number}=  eInvoice Execute SELECT query string    ${sql_total} 
    Set Test Variable    ${total}  ${return_total_number[0][0]}

Get total number of CNDN list with "${ep_username}" site '${site_mpid}' Type 'Verify document' and filter condition is 'My Approval'
     ${return_group_user}=    Query value 'GroupUser' in DB    '${ep_username}'  '${site_mpid}' 
     ${sql_total}=  Get query string for SELECT Count 'CNDNApproval' where with 'Approver' , 'ApproverGroup' and ApprovalType is 'Verify Document'  ${ep_username}  ${return_group_user[0][0]}
     ${return_total_number}=  eInvoice Execute SELECT query string    ${sql_total}  
    Set Test Variable    ${total}  ${return_total_number[0][0]}

Get total number of CNDN list with "${ep_username}" site '${site_mpid}' Type 'Verify document' and filter condition is 'Cost Center Group'
     ${return_group_user}=    Query value 'GroupUser' in DB    '${ep_username}'  '${site_mpid}' 
     ${sql_total}=  Get query string for SELECT Count 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , 'ConditionGroup' and ApprovalType is 'Verify Document'  ${ep_username}  ${return_group_user[0][0]}   ${TEXT.CONDITIONGROUP.CONDITIONGROUP}
     ${return_total_number}=  eInvoice Execute SELECT query string    ${sql_total}
    Set Test Variable    ${total}  ${return_total_number[0][0]}

Get total number of CNDN list with "${ep_username}" site '${site_mpid}' Type 'Verify document' and filter condition is 'Commercial'
     ${return_group_user}=    Query value 'GroupUser' in DB    '${ep_username}'  '${site_mpid}' 
     ${sql_total}=  Get query string for SELECT Count 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , 'ConditionGroup' and ApprovalType is 'Verify Document'  ${ep_username}  ${return_group_user[0][0]}   ${TEXT.CONDITIONGROUP.COMMERCIAL}
     ${return_total_number}=  eInvoice Execute SELECT query string    ${sql_total} 
    Set Test Variable    ${total}  ${return_total_number[0][0]}

Dropdownlist filter condition should show 'All Cost Center' at top 
    Verify dropdownlist filter condition first value is     All Cost Center

Dropdownlist filter condition should show 'My Approval' at second
    Verify dropdownlist filter condition second value is     My Approval  

Dropdownlist filter condition should show 'Cost Center Group' at bottom
    Verify dropdownlist filter condition last value is     Cost Center Group    

Dropdownlist filter condition should show 'Condition list' under my approval menu
    Verify dropdownlist filter condition under my approval menu should match with condition list of approver  

Select '${filter_condition}' from dropdownlist filter condition
    click dropdownlist filter condition on option   ${filter_condition}

Approval CN/DN list footer show total number format "${total_footer}" correctly
    ${replaced_total_footer}=    Replace Variables in YAML file    ${total_footer}
    Element Text Should Be    ${lbl_totol_footer}     ${replaced_total_footer}

Remove '${ep_user}' site '${site_mpid}' from all group user
    Update 'UserID_Temp' to field 'UserID' table 'GroupUser' with where 'UserID' in DB    ${ep_user}     '${site_mpid}'

Assign '${ep_user}' site '${site_mpid}' to an old one group user
    Update 'UserID' to field 'UserID' table 'GroupUser' with where 'UserID_Temp' in DB  ${ep_user}     '${site_mpid}'

First page of CNDN list column "${column_name}" is "${conditiongroup}"
    Table CN/DN should have at least one row
    Verify 'CN/DN' at column display value correctly    ${column_name}  ${conditiongroup} 

Search CN/DN with search keyword    
    [Arguments]     ${keyword_search}
    Wait until loading complete
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${obj_search.txt_search}     ${timeout}
    ...     AND    clear element text  ${obj_search.txt_search} 
    ...     AND    Input Text    ${obj_search.txt_search}     ${keyword_search}
    ...     AND    Click Element    ${obj_search.btn_search}
    ...     AND    Wait until loading complete

Click icon 'tax filter' in column 'CN/DN Number'
    Click on 'tax filter' in column 'CN/DN Number'
    'Tax Invoice' list display

There are "${all_status}", "${with_tax_invoice}", "${no_tax_invoice}" in dropdown list
    'Tax Invoice' list has choice    ${all_status}
    'Tax Invoice' list has choice    ${with_tax_invoice}
    'Tax Invoice' list has choice    ${no_tax_invoice}

Select "${item_name}" in dropdown list
    Click on item in 'Tax Invoice' list    ${item_name}

Table display top 20 results 'With Tax Invoice' match with DB
    ${db_results}=  Get result in DB for 'With Tax Invoice'
    Result table 'With Tax Invoice' data should be equal to DB data    ${db_results}

Table display top 20 results 'No Tax Invoice' match with DB
    ${db_results}=  Get result in DB for 'No Tax Invoice'
    Result table 'No Tax Invoice' data should be equal to DB data    ${db_results}

Filter icon status 'Active' with blue color
   'Tax Invoice' icon is been highlight with blue color    

Go to 'Edit CN/DN page' of CN/DN Number "${CNDNNum}" via action button
   Search CN/DN with search keyword    ${CNDNNum}      
   Click menu three dot at first row                    
   Click action "Edit"  

User search CNDN "${cndn_num}"          
    cndn_approve_keywords.Search CN/DN with search keyword    ${cndn_num}

User search CNDN "${cndn_num}" which has information icon 
    Search CN/DN with search keyword    ${cndn_num}

User select CNDN "${cndn_num}" 
    Click on first row of 'CN/DN' table    ${TEXT.CREATE_DATE}   

User select CNDN                  
    cndn_approve_keywords.Click first row of 'Approval CN/DN' table           

user clicked at CNDN which has information icon first row     
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}      

Search CNDN Number with keyword "${keyword_search}" from all status    
    ## Implement step here!!!

Rejected Icon should be display 
    ## Implement step here!!!

Approved Icon should be display
    ## Implement step here!!!

Awaiting Icon should be display
    ## Implement step here!!!

Suspend Icon should be display
    ## Implement step here!!!

Pending Icon should be display
    ## Implement step here!!!

Processing Icon should be display
    ## Implement step here!!!

Verify Group Approval display text
    ## Implement step here!!!

Verify Approval detail on CNDN Number "${invoice_number}" correctly
    ## Implement step here!!!
    
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
Select 'Approve CN/DN'
    Click Element    ${menu_approve_cndn_locator}
    Wait until loading complete   

Click on 'CN/DN' menu on left side
    Click Element    ${obj_cndn_status.right_menu.lnk_cndn_menu}
    Wait until loading complete

Verify page 'CN/DN' display
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.btn_create_invoice_label}    ${TIMEOUT}

Verify page 'Approve CN/DN' display
    Wait Until Element Is Visible    ${approve_cndn_label}

Table CN/DN should have at least one row
    ${row_count}=    Get Element Count    ${tbl_cndn_approval_list.row_per_page}
    Should Be True    ${row_count} > 0

Click on first row of 'CN/DN' table
    [Arguments]    ${column_name}
    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_table.tbl_cndn_result_header_row}
    ${target_obj}=    Replace Variables     ${obj_table.tbl_cndn_firstrow_with_columm}
    Click Element    ${target_obj}

Click first row of 'Approval CN/DN' table
    Click Element    ${tbl_cndn_approval_list.firstrow}

Click 'Approval Status' dropdown list
    Click Element    ${ddl_approval_status}

Click 'Status' dropdown list
    Click Element    ${obj_cndn_status.cndn_status_section.ddl_cndn_status}

Click on target status
    [Arguments]   ${cndn_status}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.lbl_cndn_status}
    Click Element    ${target_obj}
    Wait until loading complete

Click on target Approval status
    [Arguments]   ${selected_approval_status}
    Set Test Variable   ${selected_approval_status}
    ${target_obj}=    Replace Variables in YAML file        ${ddl_approval_status_with_value}
    Click Element    ${target_obj}
    Wait until loading complete
  
Get CN/DN number from expect row in table
    [Arguments]    ${column}    ${row_number}
    ${ret_col_no}=    Get column number by target column name    ${column}    ${tbl_cndn_approval_list.header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable   ${ret_col_no}
    Set Test Variable    ${row_number}
    ${target_obj}=    Replace Variables in YAML file        ${tbl_cndn_approval_list.row_data_with_columm}
    ${cndn_number}=    Get Text    ${target_obj}
    [Return]    ${cndn_number}

Get CN/DN type from expect row in table
    [Arguments]    ${column}    ${row_number}
    ${ret_col_no}=    Get column number by target column name    ${column}    ${tbl_cndn_approval_list.header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable    ${ret_col_no}
    Set Test Variable    ${row_number}
    ${target_obj}=    Replace Variables in YAML file       ${tbl_cndn_approval_list.row_data_with_columm}
    ${cndn_type}=    Get Text    ${target_obj}
    [Return]    ${cndn_type}

Get CN/DN status from expect row in table
    [Arguments]    ${column}    ${row_number}
    ${ret_col_no}=    Get column number by target column name    ${column}    ${tbl_cndn_approval_list.header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable    ${ret_col_no}
    Set Test Variable    ${row_number}
    ${target_obj}=    Replace Variables in YAML file       ${tbl_cndn_approval_list.row_data_with_columm_status}
    ${cndn_status}=    Get Text    ${target_obj}
    [Return]    ${cndn_status}

Click action button at first row
    Click Element    ${btn_three_dot_first_row}

Verify action list show action correctly at specific row     
    [Arguments]     ${action}   ${row_number}
    set test variable   ${row_number}
     ${target_obj}=    Replace Variables in YAML file       ${cndn_firstrow_action_list_with_data_and_row_number}
    Element Text Should Be      ${target_obj}       ${action}

Search invoice with search keyword
    [Documentation]    Search CNDN with keyword search, keyword search is an arguments
    [Arguments]    ${keyword_search}

    Wait until loading complete
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${obj_search.txt_search}     ${timeout}
    ...     AND    clear element text  ${obj_search.txt_search} 
    ...     AND    Input Text    ${obj_search.txt_search}     ${keyword_search}
    ...     AND    Click Element    ${obj_search.btn_search}
    ...     AND    Wait until loading complete

Click menu three dot at first row     
    [Documentation]    Click button three dot at the first row

    Wait Until Element Is Visible    ${btn_three_dot_first_row}
    Click Element    ${btn_three_dot_first_row}      

Click action "History"
    [Documentation]    Click action "History" option

    Wait Until Element Is Visible    ${obj_action_menu.history}
    Click Element    ${obj_action_menu.history}   
    Wait until loading complete 

Click action "Edit"
    Wait Until Element Is Visible    ${obj_action_menu.edit}
    Click Element    ${obj_action_menu.edit}   
    Wait until loading complete 

Click dropdownlist filter condition
    Wait Until Element Is Visible    ${ddl_filter_condition_locator}
    Click Element    ${ddl_filter_condition_locator}      

Click dropdownlist filter condition on option   
    [Arguments]     ${filter_condition}
    Set Test Variable    ${filter_condition}
    ${ddl_filter_condition_at_option_locator}=    Replace Variables in YAML file    ${ddl_filter_condition_on_option_locator}
    Click Element    ${ddl_filter_condition_at_option_locator}   
    Wait until loading complete  

Verify dropdownlist filter condition first value is
    [Arguments]     ${expect_msg}
    Wait Until Element Is Visible    ${ddl_filter_condition_top_value_locator}    
    Element Text Should Be    ${ddl_filter_condition_top_value_locator}     ${expect_msg}

Verify dropdownlist filter condition second value is        
    [Arguments]     ${expect_msg}
    Wait Until Element Is Visible    ${ddl_filter_condition_second_value_locator}    
    Element Text Should Be    ${ddl_filter_condition_second_value_locator}     ${expect_msg}    

Verify dropdownlist filter condition last value is        
    [Arguments]     ${expect_msg}
    ${row_number}=    Get Element Count    ${ddl_filter_condition_data_rows_locator}
    Set Test Variable    ${row_number}
    ${ddl_child_value_locator}=    Replace Variables in YAML file    ${ddl_filter_condition_bottom_value_locator}
    Wait Until Element Is Visible    ${ddl_child_value_locator}    
    Element Text Should Be    ${ddl_child_value_locator}     ${expect_msg}

Verify dropdownlist filter condition under my approval menu should match with condition list of approver  
    ${row_count}=    Get Element Count    ${ddl_filter_condition_my_approval_data_rows_locator}
    :FOR    ${row_number}    IN RANGE    1    ${row_count}
    \    Set Test Variable    ${row_number}
    \    ${row_target}=    Replace Variables in YAML file    ${ddl_filter_condition_under_my_approval_locator}
    \    ${actual}=    Get Text    ${row_target}
    \    ${expect}=    Catenate    @{condition_list[${row_number}-1]}
    \    Should Be Equal    ${expect}    ${actual}   

Verify 'CN/DN' at column display value correctly
    [Arguments]     ${column}   ${value}
    ${row_count}=    Get Element Count    ${tbl_cndn_approval_list.row_per_page}
    ${ret_col_no}=    Get column number by target column name    ${column}    ${tbl_cndn_approval_list.header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable   ${ret_col_no}
    :FOR    ${row_number}    IN RANGE    1    ${row_count}
    \    Set Test Variable    ${row_number}
    \    ${row_target}=    Replace Variables in YAML file    ${tbl_cndn_approval_list.row_data_with_columm}
    \    ${actual}=    Get Text    ${row_target}
    \    Should Be Equal    ${value}    ${actual}   

Dropdownlist filter condition should display selected option
    [Arguments]     ${filter_condition}
    Element Text Should Be    ${ddl_filter_condition_selected_option_locator}     ${filter_condition} 

Click on 'tax filter' in column 'CN/DN Number'
    Click element       ${btn_tax_invoice_filter}

'Tax Invoice' list display
    Element should be visible      ${ddl_tax_invoice}

'Tax Invoice' list has choice    
    [Arguments]    ${tax_invoice_choice}
    Element Should Contain      ${ddl_tax_invoice}     ${tax_invoice_choice}

Click on item in 'Tax Invoice' list
    [Arguments]    ${item_name}  
    ${new_item_name}      Replace String      ${item_name}    ${space}    ${empty}
    Click element   ${ddl_tax_invoice_${new_item_name}}

Get result in DB for status    
    [Arguments]     ${cndn_status}
    ${return_group_user}=    Query value 'GroupUser' in DB    '${TRUE_VERIFY_03}'  '${TRUE_MPID}'
    ${sql_list_with_status}=  Get query string for SELECT 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , 'Approval status' and ApprovalType is 'Verify Document'  ${TRUE_VERIFY_03}  ${return_group_user[0][0]}   ${cndn_status}
    ${return_approval_list}=  eInvoice Execute SELECT query string    ${sql_list_with_status} 
    [Return]   ${return_approval_list}

Get result in DB for 'With Tax Invoice'
     ${return_group_user}=    Query value 'GroupUser' in DB    '${TRUE_VERIFY_03}'  '${TRUE_MPID}'
     ${sql_tax_invoice}=  Get query string for SELECT 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , TaxInvoice is not null and ApprovalType is 'Verify Document'  ${TRUE_VERIFY_03}  ${return_group_user[0][0]}
     ${return_tax_invoice}=  eInvoice Execute SELECT query string    ${sql_tax_invoice} 
     [Return]   ${return_tax_invoice}

Get result in DB for 'No Tax Invoice'
     ${return_group_user}=    Query value 'GroupUser' in DB    '${TRUE_VERIFY_03}'  '${TRUE_MPID}'
     ${sql_tax_invoice}=  Get query string for SELECT 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , TaxInvoice is null and ApprovalType is 'Verify Document'  ${TRUE_VERIFY_03}  ${return_group_user[0][0]}
     ${return_tax_invoice}=  eInvoice Execute SELECT query string    ${sql_tax_invoice} 
     [Return]   ${return_tax_invoice}

Result table 'With Tax Invoice' data should be equal to DB data
    [Arguments]    ${db_results}
    ${Frontend_list}=   Set Approval list from frontend to list
    ${DB_list}=     Set Approval list db results to list  ${db_results}
    Lists Should Be Equal   ${Frontend_list}      ${DB_list}    ignore_order=True

Result table 'No Tax Invoice' data should be equal to DB data
    [Arguments]    ${db_results}
    ${Frontend_list}=   Set Approval list from frontend to list
    ${DB_list}=     Set Approval list db results to list  ${db_results}
    Lists Should Be Equal   ${Frontend_list}      ${DB_list}    ignore_order=True

Set Approval list db results to list  
    [Arguments]    ${db_results}
    ${rowCount}     Get Length   ${db_results}
    @{CNDNListdb}    Create List
    :FOR    ${i}    IN RANGE    0    ${rowCount}
    \   ${dictionary}=    Create Dictionary    CNDNNum=${db_results[${i}][0]}    Buyer=${db_results[${i}][2]}   Supplier=${db_results[${i}][3]}    ReceivedDate=${db_results[${i}][4]}  CostCenter=${db_results[${i}][5]}    Type=${db_results[${i}][6]}   NoteType=${db_results[${i}][7]}    IncludeVAT=${db_results[${i}][8]}     Status=${db_results[${i}][9]}
    \   Append To List    ${CNDNListdb}    ${dictionary}
    [Return]   ${CNDNListdb}

Set Approval list from frontend to list
    ${rowCount}     Get Element Count   ${tbl_cndn_approval_list.row_per_page}
    @{list}    Create List
     :FOR    ${i}    IN RANGE    0    ${rowCount}
    \   ${row_num}=   Set Variable    ${i+1}
    \   ${tbl_cell_CNDNNum}=        Replace Variables   ${obj_table.lbl_cndn_num}
    \   ${tbl_cell_Buyer}=          Replace Variables   ${obj_table.lbl_buyer} 
    \   ${tbl_cell_Supplier}=       Replace Variables   ${obj_table.lbl_supplier}
    \   ${tbl_cell_ReceivedDate}=   Replace Variables   ${obj_table.lbl_receiveddate} 
    \   ${tbl_cell_Costcenter}=     Replace Variables   ${obj_table.lbl_costcenter}
    \   ${tbl_cell_Type}=           Replace Variables   ${obj_table.lbl_type} 
    \   ${tbl_cell_NoteType}=       Replace Variables   ${obj_table.lbl_notetype}
    \   ${tbl_cell_IncludeVAT}=     Replace Variables   ${obj_table.lbl_includevat} 
    \   ${tbl_cell_Status}=         Replace Variables   ${obj_table.lbl_status}
    \   ${CNDNNum}=         Get Text    ${tbl_cell_CNDNNum}
    \   ${Buyer}=           Get Text    ${tbl_cell_Buyer}
    \   ${Supplier}=        Get Text    ${tbl_cell_Supplier}
    \   ${ReceivedDate}=    Get Text    ${tbl_cell_ReceivedDate}
    \   ${Costcenter}=      Get Text    ${tbl_cell_Costcenter}
    \   ${Type}=            Get Text    ${tbl_cell_Type}
    \   ${NoteType}=        Get Text    ${tbl_cell_NoteType}
    \   ${IncludeVAT}=      Get Text    ${tbl_cell_IncludeVAT}
    \   ${Status}=          Get Text    ${tbl_cell_Status}
    \   ${dictionary_value}=    Create Dictionary    CNDNNum=${CNDNNum}    Buyer=${Buyer}   Supplier=${Supplier}    ReceivedDate=${ReceivedDate}  CostCenter=${CostCenter}    Type=${Type}   NoteType=${NoteType}    IncludeVAT=${IncludeVAT}     Status=${Status}
    \   Append To List    ${list}    ${dictionary_value}
    [Return]    ${list} 

There is icon 'Tax Invoice' in column 'CN/DN Number' For First Row
    ${row_num}  set variable    1
    ${locator_taxicon}      Replace variables   ${obj_table.lbl_cndn_num_w_taxicon}  
    Element should be visible       ${locator_taxicon}  

Click action Close CN/DN at specifice credit/debit note number    
    [Arguments]    ${cndn_no}
    [Documentation]    Click action Close CN/DN at CN/DN Approval List at the specific row

    # Find the specific row that matching with credit/debit note number
    ${row_no}    cndn_approve_keywords.Find specific row on select data in column    ${cndn_no}
    
    #${row_no}    Convert To String    ${row_no}
    #Debug
    #${btn_action_specific_row}    Replace String    ${btn_action_specific_row}    REPLACE_ME    ${row_no}    
    #${btn_action_option_specific_row}    Replace String    ${btn_action_option_specific_row}    REPLACE_ME   ${row_no}
    #${actions.close_cndn}    Replace String    ${actions.close_cndn}    REPLACE_ME    ${row_no}
    ${btn_action_specific_row}    Replace Variables    ${btn_action_specific_row}
    ${btn_action_option_specific_row}    Replace Variables    ${btn_action_option_specific_row}
    ${actions.close_cndn}    Replace Variables    ${actions.close_cndn}

    Click Element    ${btn_action_specific_row}   

    Wait Until Element Is Visible    ${btn_action_option_specific_row}    
    Click Element    ${actions.close_cndn}    

Find specific row on select data in column    
    [Arguments]    ${expected_text}
    [Documentation]    Find the table row that table row cell matching expected text         

    #initial row number variable value
    ${row_number}    Set Variable    0

    #get row count that display on ui
    ${end}=    Get Element Count    ${tbl_cndn_approval_list.row_per_page} 

    ${end}    Evaluate    ${end}+1
    ${start}    Set Variable    1    
    :FOR    ${index}    IN RANGE    ${start}    ${end}
        #convert Integers to Strings because keyword "Replace String" not acceptable type Integer
        ${row}    Convert To String    ${index}
        #Debug
        #${selected_row}    Replace String    ${tbl_cndn_approval_list.row_specific_number}    REPLACE_ME    ${row}
        ${selected_row}    Replace Variables    ${tbl_cndn_approval_list.row_specific_number}
        ${actual}    Get Text     ${selected_row}   
        ${is_equal}    Run Keyword And Return Status    Should Be Equal    ${expected_text}    ${actual}
        ${row_number}    Set Variable    ${index}

        Run Keyword If    '${is_equal}'=='True'    Exit For Loop
    END

    Return From Keyword    ${row_number}      