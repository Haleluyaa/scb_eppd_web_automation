*** Settings ***
Variables    ../../../resources/locators/cn_dn/view_cndn_locators.yaml

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
Message for Header section display all expected "${message_header_section}" correctly
    ${message_header_section}=    Replace Variables in YAML file    ${message_header_section}
    ${items_count}=    Get Length    ${message_header_section}
    :FOR    ${i}    IN RANGE    0    ${items_count}-1
    \    Verify label should display on header section in 'View Credit / Debit Note' page    ${message_header_section[${i}]}

Message for Credit/Debit note section display all expected "${message_cndn_section}" correctly
    ${message_cndn_section}=    Replace Variables in YAML file    ${message_cndn_section}
    ${items_count}=    Get Length    ${message_cndn_section}
    :FOR    ${i}    IN RANGE    0    ${items_count}-1
    \    Verify label should display on header section in 'View Credit / Debit Note' page    ${message_cndn_section[${i}]}

Message for Invoice section display all expected "${message_invoice_section}" correctly
    ${message_invoice_section}=    Replace Variables in YAML file    ${message_invoice_section}
    ${items_count}=    Get Length    ${message_invoice_section}
    :FOR    ${i}    IN RANGE    0    ${items_count}-1
    \    Verify label should display on header section in 'View Credit / Debit Note' page    ${message_invoice_section[${i}]}

user clicked at information icon on view CNDN page
    Click on information icon

'View Credit/ Debit note' page display
    Verify page 'View Credit/ Debit note' display

Action bar on top display button 'Edit', 'Print Cover', 'Print Billing', 'History'
    Verify action bar display button 'Edit', 'Print Cover', 'Print Billing', 'History'

Action bar on top display button 'Print Cover', 'Print Billing', 'History'
    Verify action bar on top display button 'Print Cover', 'Print Billing', 'History'

Action bar on top display button 'Print Billing', 'History'
    Verify action bar on top display button 'Print Billing', 'History'

Action bar on top display button 'History'
    Verify action bar on top display button 'History'

"${label_1}", "${label_2} and "${label_3}" is hidden
    Verify no 3 fields is hidden from 'View Credit/Debit note' screen     ${label_1}    ${label_2}    ${label_3}

Click first row of Invoice at column "${column_name}" to see GR detail
    Click first row of 'Invoice'    ${column_name}
    Verify 'View GR Detail' modal display

GR detail on modal should match with DB
    ${return_gr_items}=    Query value 'CNDNItemDetail' in DB    '${cndn_no}'
    GR Detail should be equal to DB    ${return_gr_items}

Click 'X' mark to close 'View GR Detail' modal
    Click 'X' to close modal
    Verify page 'View Credit/ Debit note' display

Click menu "History" at top right corner
    Click action history

Click menu "Edit" at top right corner
    Click action edit
    
Click print Cover in CN/DN view
    Click CN/DN view's print cover button 

Click print Billing in CN/DN view
    Click CN/DN view's print billing button 

Hint Modal is shown
    Verify Modal visibility

Modal shown correct data "${cndn_num}"
    ${msg_date}     Get data that show on information need modal from db    ${cndn_num}
    ${user_firstname}   Get firstname on information need modal from db     ${msg_date[0][2]}     ${TRUE_EID}
    Verify message,buyer name,date and time of Request from Buyer with DB       ${msg_date}     ${user_firstname}

Success bar is shown "${success_msg}" with CNDNNumber '${cndnnumber_req}'
    Verify page 'CN/DN' display
    ${success_msg}     Replace variables   ${success_msg}
    Verify Success bar visibility with massage      ${success_msg}

CNDN "${cndn_num}" status is "${cndnstatus}"
    Search CNDN with search keyword    ${cndn_num}
    Verify if CNDN status is    ${cndnstatus}

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

Verify label should display on header section in 'View Credit / Debit Note' page
    [Arguments]    ${expected_message}    
    Element Should Contain    ${obj_view_cndn.lbl_section_header}    ${expected_message}    

Verify label should display on detail section in 'View Credit / Debit Note' page
    [Arguments]    ${expected_message}    
    Element Should Contain    ${obj_view_cndn.lbl_section_under}    ${expected_message}

Verify page 'View Credit/ Debit note' display  
    Wait Until Element Is Visible    ${obj_view_cndn.lbl_header}    ${TIMEOUT}

Verify action bar display button 'Edit', 'Print Cover', 'Print Billing', 'History'
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_edit}    ${TIMEOUT}
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_cover}    ${TIMEOUT}
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_billing}    ${TIMEOUT}
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_history}    ${TIMEOUT}

Verify action bar on top display button 'Print Cover', 'Print Billing', 'History'
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_cover}    ${TIMEOUT}
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_billing}    ${TIMEOUT}
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_history}    ${TIMEOUT}

Verify action bar on top display button 'Print Billing', 'History' 
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_billing}    ${TIMEOUT}
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_history}    ${TIMEOUT}

Verify action bar on top display button 'History'
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_history}    ${TIMEOUT}
    
Verify no 3 fields is hidden from 'View Credit/Debit note' screen 
    [Arguments]    ${label_1}    ${label_2}    ${label_3}
    Element Should Not Contain    ${obj_view_cndn.div_view_cndn}    ${label_1}
    Element Should Not Contain    ${obj_view_cndn.div_view_cndn}    ${label_2}
    Element Should Not Contain    ${obj_view_cndn.div_view_cndn}    ${label_3}

GR Detail should be equal to DB
    [Arguments]    ${return_gr_items}
    ${row_count}=    Get Element Count    ${obj_view_cndn.gr_detail_modal.tbl_gr_data_rows}
    :FOR    ${row_number}    IN RANGE    1    ${row_count}
    \    Set Test Variable    ${row_number}
    \    ${row_target}=    Replace Variables in YAML file    ${obj_view_cndn.gr_detail_modal.tbl_gr_data_specify_row}
    \    ${actual}=    Get Text    ${row_target}
    \    ${expect}=    Catenate    @{return_gr_items[${row_number}-1]}
    \    ${expect}=    Replace String    ${expect}    ${SPACE * 2}    ${SPACE}
    \    Should Be Equal    ${expect}    ${actual}

Verify 'View GR Detail' modal display
    Wait Until Page Contains Element    ${obj_view_cndn.gr_detail_modal.div_modal_gr_detail}    ${TIMEOUT}

Click 'X' to close modal
    Wait Until Page Contains Element    ${obj_view_cndn.gr_detail_modal.lbl_x_mark_to_close}    ${TIMEOUT}
    Click Element    ${obj_view_cndn.gr_detail_modal.lbl_x_mark_to_close}

Click first row of 'Invoice'
    [Arguments]    ${column_name}    
    ${ret_col_no}=  Get column number by target column name    ${column_name}    ${obj_view_cndn.cndn_detail_section.tbl_invoice_header_with_columm}
    ${target_obj}=    Replace Variables     ${obj_view_cndn.cndn_detail_section.tbl_invoice_firstrow_with_columm}
    Click Element    ${target_obj}

Click CN/DN view's print cover button
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_cover}   ${TIMEOUT}
    Click Element    ${obj_view_cndn.action.btn_print_cover}

Click CN/DN view's print billing button 
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_print_billing}   ${TIMEOUT}
    Click Element    ${obj_view_cndn.action.btn_print_billing}
    
Click action history  
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_history}    ${TIMEOUT}
    Click Element    ${obj_view_cndn.action.btn_history}     
    Wait until loading complete

Click action edit  
    Wait Until Element Is Visible    ${obj_view_cndn.action.btn_edit}    ${TIMEOUT}
    Click Element    ${obj_view_cndn.action.btn_edit}     
    Wait until loading complete     

Verify Modal visibility
    Wait Until Element Is Visible   ${modal_information_need.modal}    ${TIMEOUT}

Click on information icon
    Wait Until Element Is Visible    ${obj_view_cndn.btn_information_need}   ${TIMEOUT}
    Click Element    ${obj_view_cndn.btn_information_need} 

Get data that show on information need modal from db
    [Arguments]     ${cndn_num}
    ${sql_modal}=     Get query string for SELECT 'CNDN' where with 'CNDNNumber'    ${cndn_num}
    ${return_modal_data}=  eInvoice Execute SELECT query string    ${sql_modal}
    [Return]    ${return_modal_data} 

Get firstname on information need modal from db 
    [Arguments]     ${Username}     ${eid}
    ${sql_firstname}=     Get query string for SELECT 'Users' where with 'Username','eid'   ${Username}     ${eid}
    ${return_firstname}=  RBAC Execute SELECT query string    ${sql_firstname}
    [Return]    ${return_firstname[0][0]}       

Verify message,buyer name,date and time of Request from Buyer with DB
    [Arguments]     ${msg_date}     ${user_firstname}
    Element text should be      ${modal_information_need.lbl_note}     ${msg_date[0][0]}
    Element text should be      ${modal_information_need.lbl_date}      ${msg_date[0][1]}
    Element text should be      ${modal_information_need.lbl_buyer}      ${user_firstname}    

Verify Success bar visibility with massage
    [Arguments]     ${expect_successbar}
    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    ${actual_successbar}    Get Text     ${lbl_success_bar}
    Should Contain Any    ${expect_successbar}    ${actual_successbar}    

Verify if CNDN status is
    [Arguments]     ${expect_status}
    Wait Until Element Is Visible    ${obj_table.lbl_status_firstrow}    ${TIMEOUT}
    Element text should be    ${obj_table.lbl_status_firstrow}    ${expect_status}        