*** Settings ***
Variables    ../../../resources/locators/cn_dn/cndn_edit_locators.yaml

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

Due date selection visible and display correctly   
    Due date selection is visible  
    Due date display date   ${CNDN_Duedate} 

Payment location ddl visible and display correctly 
    Payment location ddl is visible
    Payment location ddl display text   ${CNDN_PaymentLocation}

Verify page 'Edit CN/DN' display
    Verify page 'Edit Credit/ Debit note' display

Edit CN/DN detail page of CN/DN Number "${CNDNNum}" Type "${CNDNType}" should match with DB
     Query value 'CNDNItemDetail' in DB for buyer  ${CNDNNum}  ${CNDNType}                      
    ${CNDNHeader}=    Get CNDN Header value to list                              
    ${CNDNDetail}=    Get CNDN Detail value to list                               
    ${CNDNInvoice}=    Get CNDN Invoice value to list                             
    Lists Should Be Equal   ${CNDNItemHeader}      ${CNDNHeader}    ignore_order=True                     
    Lists Should Be Equal   ${CNDNItemDetail}      ${CNDNDetail}    ignore_order=True                     
    Lists Should Be Equal   ${CNDNItemInvoice}     ${CNDNInvoice}   ignore_order=True                     
    Get CNDN Duedate from List      ${CNDNItemHeader}
    Get CNDN Payment Location from List     ${CNDNItemHeader}

Click 'X' mark to close 'Edit CN/DN page'
    Click 'X' to close page
    Verify 'Leave Without Approve' display

Click 'Leave' on Modal 'Leave Without Approve'
    Click 'Leave' button

Click 'Stay on this Page' on Modal 'Leave Without Approve'
    Click 'Stay on this Page' button   

Select due date to within date    
    Click 'Within' radio button 

Select payment location to "${payment_location}"
    Click drop down payment location
    Click selected payment location    ${payment_location}

Select approve credit/debit note
    Click approve button  

Click approve cndn on approved modal with note "${approve_note}"    
    Input approve note    ${approve_note}
    Click confirm button to approved cndn
        

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

Click confirm button to approved cndn
    Wait Until Element Is Visible    ${approve_modal.btn_confirm}
    Click Element    ${approve_modal.btn_confirm}

Input approve note
    [Arguments]    ${input_text}
    Wait Until Element Is Visible    ${approve_modal.txt_approved_note}   
    Input Text   ${approve_modal.txt_approved_note}    ${input_text}    

Due date selection is visible 
    Element Should Be Visible   ${due_date_calendar}
    Element Should Be Visible   ${rdl_due_date_date}
    Element Should Be Visible   ${rdl_due_date_within}
    Element Should Be Visible   ${txt_due_date_within}

Payment location ddl is visible
    Element Should Be Visible   ${ddl_payment_location}

Due date display date
    [Arguments]     ${dd}
    ${date}=     Get Value      ${due_date_calendar}
    Should Be Equal     ${date}     ${dd}

Payment location ddl display text   
    [Arguments]     ${PaymentLocation}    
    ${Payment_text}=    Get Selected List Label     ${ddl_payment_location}
    Should Be Equal     ${PaymentLocation}      ${Payment_text}

Click approve button
    Wait Until Element Is Visible    ${btn_approve}    
    Click element       ${btn_approve}   

Click 'X' to close page
    Wait Until Element Is Visible    ${btn_x}    ${timeout} 
    click element   ${btn_x}    

Verify 'Leave Without Approve' display
    Element Should Be Visible   ${mdl_leave_without_approve.mdl}

Click 'Leave' button
    Click element       ${mdl_leave_without_approve.btn_leave}

Click 'Stay on this Page' button
    Click element       ${mdl_leave_without_approve.btn_stay}

Verify page 'Edit Credit/ Debit note' display
    Wait Until Element Is Visible    ${edit_cndn_head_label}    

Get CNDN Duedate from List      
    [Arguments]     ${List}
    ${CNDN_Duedate}=    Set Variable    ${List[0]['Duedate']}
    Set test variable   ${CNDN_Duedate}

Get CNDN Payment Location from List     
    [Arguments]     ${List}
    ${CNDN_PaymentLocation}=    Set Variable    ${List[0]['PaymentLocation']}
    Set test variable   ${CNDN_PaymentLocation}   

Click 'Within' radio button
    Wait Until Element Is Visible    ${rdl_due_date_within}
    Select Radio Button    ${rdl_due_date_group}    ${rdl_due_date_name}

Click drop down payment location
    Wait Until Element Is Visible    ${ddl_payment_location}
    Click Element    ${ddl_payment_location}

Click selected payment location    
    [Arguments]    ${payment_location} 

    ${ddl_selected_payment_location}    Replace Variables    ${ddl_selected_payment_location}   
    Wait Until Element Is Visible    ${ddl_selected_payment_location}
    Click Element    ${ddl_selected_payment_location}

#Click approve button 
#    Wait Until Element Is Visible    //button[@class="btn-op-primary btn-half false" and text() = 'Approve' or text() ='อนุมัติ']
#    Click Element    //button[@class="btn-op-primary btn-half false" and text() = 'Approve' or text() ='อนุมัติ']        
    
                