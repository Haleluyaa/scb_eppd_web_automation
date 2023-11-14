*** Settings ***
Variables    ../../../resources/locators/cn_dn/cndn_status_locators.yaml

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
Go to menu CN/DN
    Click on 'CN/DN' menu on left side
    Verify page 'CN/DN' display

Click first row of CN/DN at column "${column_name}"
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${column_name}
    
Search CN/DN with status "${cndn_status}"
    Click 'Status' dropdown list
    Click on target status    ${cndn_status}

Get target CN/DN No. at column "${column_name}" at row "${row_num}" 
    Table CN/DN should have at least one row
    ${cndn_no}=  Get CN/DN number from expect row in table    ${column_name}    ${row_num}
    Set Test Variable    ${cndn_no}

Set value in DB for 'Due Date​' as "${db_duedate_value}", 'Payment Location' as "${db_paymentlocation_value}" and 'Note to Buyer​' as "${db_notetobuyer_value}"
    Set value to field 'Due Date​', 'Payment Location' and 'Note to Buyer​' in DB    ${db_duedate_value}    ${db_paymentlocation_value}    ${db_notetobuyer_value}    '${cndn_no}'
    Reload Page
    Wait until loading complete
 
Set value in DB for 'CN/DN status' as "${cndn_status}"
    Update value to field 'CN/DN status' in DB    ${cndn_status}    '${cndn_no}'

User select action button of any CN/DN that status is Awaiting Approval
    Click 'Status' dropdown list
    Click on target status    Awaiting Approval
    Click on action button

User select any CN/DN that status is Awaiting Approval
    Click 'Status' dropdown list
    Click on target status    Awaiting Approval
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${TEXT.CREATE_DATE}

User select any CN/DN that status is Rejected
    Click 'Status' dropdown list
    Click on target status    Rejected
    Table CN/DN should have at least one row
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select action button of any CN/DN that status is Rejected
    Click 'Status' dropdown list
    Click on target status    Rejected
    Click on action button

User search CNDN "${cndn_num}" which has information icon 
    Search CNDN with search keyword    ${cndn_num}

User search CNDN "${cndn_num}" which needed to resubmit
    Search CNDN with search keyword    ${cndn_num}

User select CNDN "${cndn_num}" 
    Click on first row of 'CN/DN' table    ${TEXT.CREATE_DATE} 

Click print billing
    Click print billing button

Browser should open new tab with print preview of Billing Statement 
    Verify if Browser is open new tab

Print billing button should not visible
    Verify availability of Print billing button

Click print cover
    Click print cover button

Browser should open new tab with print preview of Billing Cover. 
    Verify if Browser is open new tab

Print cover button should not visible
    Verify availability of Print cover button

Click menu history on "${invoice_number}"    
    Search CNDN with search keyword    ${invoice_number}
    Click menu three dot at first row
    Click action "History"

Go to "CNDN Staus Page" on specific invoice number "${invoice_number}" on column "${column_name}"   
    Search CNDN with search keyword    ${invoice_number}
    Click on first row of 'CN/DN' table    ${column_name}

Close tab and Go back to cndn status page
    Close window in case tab more than one
    Switch window to main window    

Filter credit/debit note with status "${cndn_status}"
    Click drop down list for select status
    Click seleced status in drop down list panel    ${cndn_status}  

User get cndn data for validate from invoice list invoice on row "${row_num}"  
    Get cndn num on selected row number    ${row_num}
    Get buyer name on selected row number    ${row_num}
    Get cndn create date on selected row number    ${row_num}   

User clicked action button on row "${row_number}"
    Click action number on selected row    ${row_number} 

User choose cndn options "${action}" at row "${row_number}"
    Choose cndn action from clik options three dot list    ${action}    ${row_number}

User click on specificed invoice row "${row_number}" at column "${column_no}" 
    Wait until loading complete
    Click on specificed row at specificed column     ${row_number}    ${column_no}     

User get credit/debit note data for validate from invoice list invoice on row "${row_num}"  
    Get cndn num on selected row number    ${row_num}
    Get buyer name on selected row number    ${row_num}
    Get cndn create date on selected row number    ${row_num}  

User clicked action three dot button on row "${row_number}"
    Click three dot action number on selected row    ${row_number}   

User click on specificed cndn row "${row_number}" at column "${column_no}" 
    Wait until loading complete
    Click on specificed row at specificed column     ${row_number}    ${column_no}           
    
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
#Get cndn num on selected row number
#    [Arguments]    ${row_num}

#    ${target_cel}    Replace Variables    ${tbl_cndn_list['col_cndn_num']}
#    Wait until loading complete
#    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
#    ${TV_cndn_num}    Get Text    ${target_cel}

#    Set Test Variable    ${TV_cndn_num}


# Get buyer name on selected row number
#     [Arguments]    ${row_num}

#     ${target_cel}    Replace Variables    ${tbl_cndn_list['col_buyer']}
#     Wait until loading complete
#     Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
#     ${TV_buyer_name}    Get Text    ${target_cel}

#     Set Test Variable    ${TV_buyer_name}

# Get cndn create date on selected row number
#     [Arguments]    ${row_num}

#     ${target_cel}    Replace Variables    ${tbl_cndn_list['col_create_date']}

#     Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
#     ${TV_cndn_create_date}    Get Text    ${target_cel}

#     Set Test Variable    ${TV_cndn_create_date}

Click on specificed row at specificed column
    [Arguments]    ${row_number}    ${ret_col_no}
    #debug
    ${invoice_row}    Replace Variables    ${select_row_col}
    Wait until loading complete
    Wait Until Element Is Visible    ${invoice_row}    ${TIMEOUT}
    Click Element    ${invoice_row}       

Choose cndn action from options list  
    [Arguments]    ${action}    ${row_number}

    ${row_num}    Evaluate    ${row_number}-1

    ${target_cel}    Replace Variables    ${action_cndn['history']}
    Wait until loading complete
    Wait Until Element Is Visible     ${target_cel}
    Click Element    ${target_cel}

Choose cndn action from clik options three dot list  
    [Arguments]    ${action}    ${row_number}

    ${row_num}    Evaluate    ${row_number}-1

    ${target_cel}    Replace Variables    ${action_cndn['history']}
    Wait until loading complete
    Wait Until Element Is Visible     ${target_cel}
    Click Element    ${target_cel}    

Click action number on selected row
    [Arguments]    ${row_number}
    #Row start from 1, but index start from 0
    ${row_index}    Evaluate    ${row_number}-1
    ${target_action_row}    Replace Variables    ${btn_action}

    Wait until loading complete
    Wait Until Element Is Visible    ${target_action_row}    ${TIMEOUT}
    Click Element    ${target_action_row}

Click three dot action number on selected row
    [Arguments]    ${row_number}
    #Row start from 1, but index start from 0
    ${row_index}    Evaluate    ${row_number}-1
    ${target_action_row}    Replace Variables    ${btn_action}

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

Click drop down list for select status
    Wait until loading complete
    Sleep    2s
    ${IsVisible}    Run Keyword And Return Status    Element Should Be Visible     ${obj_cndn_status['cndn_status_section']['ddl_cndn_status']}  
    Run Keyword If    ${IsVisible}     Click Element    ${obj_cndn_status['cndn_status_section']['ddl_cndn_status']} 
    ...    ELSE    Pass Execution    No data
    #Wait Until Element Is Visible    ${obj_cndn_status['cndn_status_section']['ddl_cndn_status']}    ${TIMEOUT}
    #Click Element    ${obj_cndn_status['cndn_status_section']['ddl_cndn_status']} 

Click seleced status in drop down list panel    
    [Arguments]    ${cndn_status}

    ${target_status}    Replace Variables    ${obj_cndn_status['cndn_status_section']['lbl_cndn_status']}
    
    Wait Until Element Is Visible     ${target_status}     ${TIMEOUT}
    Click Element    ${target_status}
    Wait until loading complete


Click on 'CN/DN' menu on left side
    Wait until loading complete
    Wait Until Element Is Visible   ${obj_cndn_status.right_menu.lnk_cndn_menu}     ${TIMEOUT}
    Click Element    ${obj_cndn_status.right_menu.lnk_cndn_menu}
    Wait until loading complete

Verify page 'CN/DN' display
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.btn_create_invoice_label}    ${TIMEOUT}

Table CN/DN should have at least one row
    ${row_count}=    Get Element Count    ${obj_cndn_status.cndn_status_section.tbl_cndn_result_row}
    Should Be True    ${row_count} > 0

Click on first row of 'CN/DN' table
    [Arguments]    ${column_name}
    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_cndn_status.cndn_status_section.tbl_cndn_result_header_row}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.tbl_cndn_firstrow_with_columm}
    Click Element    ${target_obj}

Click 'Status' dropdown list
    Click Element    ${obj_cndn_status.cndn_status_section.ddl_cndn_status}

Click on target status
    [Arguments]   ${cndn_status}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.lbl_cndn_status}  #${cndn_status}
    Wait Until Element Is Visible    ${target_obj}   ${TIMEOUT}
    Click Element    ${target_obj}
    Wait until loading complete

Get CN/DN number from expect row in table
    [Arguments]    ${column_name}    ${row_no}
    ${ret_col_no}=    Get column number by target column name    ${column_name}    ${obj_cndn_status.cndn_status_section.tbl_cndn_result_header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.tbl_cndn_firstrow_data_with_columm}  #${ret_col_no}
    ${cndn_number}=    Get Text    ${target_obj}
    [Return]    ${cndn_number}

Click on action button
    Click Element    ${obj_cndn_status.cndn_action_menu.btn_action_menu}

Click print billing button
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}   ${TIMEOUT}
    Click Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}

Click print cover button
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_cover}   ${TIMEOUT}
    Click Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_cover}

Verify if Browser is open new tab 
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    Switch Window    NEW
    ${windows}=    Get Window Handles
    ${numWindows}=    Get Length  ${windows}
    Should Be True    ${numWindows} > 1

Verify availability of Print cover button
    Page Should Not Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_cover}

Verify availability of Print billing button
    Page Should Not Contain Element    ${obj_cndn_status.cndn_action_menu.btn_cndn_print_billing}
    
Search CNDN with search keyword
    [Documentation]    Search CNDN with keyword search, keyword search is an arguments
    [Arguments]    ${keyword_search}

    Wait until loading complete
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${obj_search.txt_search}     ${timeout}
    ...     AND    clear element text  ${obj_search.txt_search} 
    ...     AND    Input Text    ${obj_search.txt_search}     ${keyword_search}
    ...     AND    Click Element    ${obj_search.btn_search}
    ...     AND    Wait until loading complete
    Log     ${keyword_search}   

Click menu three dot at first row     
    [Documentation]    Click button three dot at the first row

    Wait Until Element Is Visible    ${btn_three_dot_first_row}
    Click Element    ${btn_three_dot_first_row}

Click action "History"
    [Documentation]    Click action "History" option

    Wait Until Element Is Visible    ${obj_action_menu.history}
    Click Element    ${obj_action_menu.history}   
    Wait until loading complete     

Check default value of filter

Switch window to main window   
    ${mainWindows}=     Get Window Handles
    Select Window       ${mainWindows[0]}

Close window in case tab more than one
    ${mainWindows}=     Get Window Handles
    ${window_num}=  Get Length      ${mainWindows}
    Run keyword if  '${window_num}' > '1'     close window


       