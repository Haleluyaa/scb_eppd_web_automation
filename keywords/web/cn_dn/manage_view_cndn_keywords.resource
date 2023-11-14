*** Settings ***
Variables    ../../../resources/locators/cn_dn/manage_view_cndn_locator.yaml

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
User view selected CN/DN Detail
    Verify page 'CN/DN' detail display

Click first row of Invoice at column "${column_name}" to see GR detail
    Click on first row of 'Invoice' table    ${column_name}

Click 'X' mark to close 'View CNDN' page
    Click 'X' on action bar

Click 'X' mark to close 'View GR Detail' modal
    Click 'X' to close modal
    Verify 'View GR Detail' modal closed
    Verify page 'CN/DN' detail display

GR detail on modal should match with DB
    ${return_po_items}=    Query value 'CNDNItemDetail' in DB with 'CNDNNo' , 'InvoiceNo' for PONUM GRNUM   '${cndn_no}'  '${invoice_no}'
    ${return_gr_items}=    Query value 'CNDNItemDetail' in DB with 'CNDNNo' , 'InvoiceNo' for GR Detail     '${cndn_no}'  '${invoice_no}'
    PONum , GRNum should be equal to DB    ${return_po_items}
    GR Detail should be equal to DB    ${return_gr_items}

Go to 'View CN/DN detail page' of CN/DN Number "${CNDNNumber}"

    manage_cndn_keywords.Search CN/DN with search keyword    ${CNDNNumber}
    Click first row of 'Manage CN/DN'
    Set Test Variable   ${cndn_no}  ${CNDNNumber}

Message for Header section display all expected "${msg_header_section}" correctly
    ${msg_header_section}=    Replace Variables in YAML file    ${msg_header_section}
    ${items_count}=    Get Length    ${msg_header_section}
    :FOR    ${i}    IN RANGE    0    ${items_count}-1
    \    Verify label should display on header section in 'View Credit / Debit Note' page    ${msg_header_section[${i}]}

Message for Credit/Debit note section display all expected "${msg_cndn_section}" correctly
    ${msg_cndn_section}=    Replace Variables in YAML file    ${msg_cndn_section}
    ${items_count}=    Get Length    ${msg_cndn_section}
    :FOR    ${i}    IN RANGE    0    ${items_count}-1
    \    Verify label should display on detail section in 'View Credit / Debit Note' page    ${msg_cndn_section[${i}]}

Message for Invoice section display all expected "${msg_invoice_section}" correctly
    ${msg_invoice_section}=    Replace Variables in YAML file    ${msg_invoice_section}
    ${items_count}=    Get Length    ${msg_invoice_section}
    :FOR    ${i}    IN RANGE    0    ${items_count}-1
    \    Verify label should display on detail section in 'View Credit / Debit Note' page    ${msg_invoice_section[${i}]}

View CN/DN detail page of CN/DN Number "${CNDNNum}" Type "${CNDNType}" should match with DB
    Query value 'CNDNItemDetail' in DB for buyer  ${CNDNNum}  ${CNDNType}
    ${CNDNHeader}=    Get CNDN Header value to list
    ${CNDNDetail}=    Get CNDN Detail value to list
    ${CNDNInvoice}=    Get CNDN Invoice value to list
    Lists Should Be Equal   ${CNDNItemHeader}      ${CNDNHeader}    ignore_order=True
    Lists Should Be Equal   ${CNDNItemDetail}      ${CNDNDetail}    ignore_order=True
    Lists Should Be Equal   ${CNDNItemInvoice}     ${CNDNInvoice}   ignore_order=True

View CN/DN detail page of CN/DN Number "${CNDNNum}" should match with DB
    Query value 'CNDNItemDetail' in DB for buyer manage cndn    ${CNDNNum}
    ${CNDNHeader}=    Get CNDN Header value to list
    ${CNDNDetail}=    Get CNDN Detail value to list
    ${CNDNInvoice}=    Get CNDN Invoice value to list
    Lists Should Be Equal   ${CNDNItemHeader}      ${CNDNHeader}    ignore_order=True
    Lists Should Be Equal   ${CNDNItemDetail}      ${CNDNDetail}    ignore_order=True
    Lists Should Be Equal   ${CNDNItemInvoice}     ${CNDNInvoice}   ignore_order=True    

"${label_1}", "${label_2} and "${label_3}" is hidden
    Verify no 3 fields is hidden from 'View Credit/Debit note' screen     ${label_1}    ${label_2}    ${label_3}    

Get target Invoice No. at column "${column_name}" at row "${row_number}"
    ${invoice_no}=  Get Invoice number from expect row in table    ${column_name}    ${row_number}
    Set Test Variable    ${invoice_no}

Click menu "History" at top right corner
    [Documentation]    Click action History

    Click history button

Green attachment icon display for 'CNDN level'
    Verify Green attachment icon display in 'CNDN level'

Green attachment icon display for 'Invoice level'
    Verify Green attachment icon display in 'Invoice level' at first row

Attachment icon display for 'CNDN level' with message "${message}"
    Verify attachment icon display in 'CNDN level'
    Click attachment icon on 'CNDN level'
    Verify modal display message    '${message}'

Attachment icon display for 'Invoice level' with message "${message}" 
    Verify attachment icon display in 'Invoice level' at first row
    Click attachment icon on 'Invoice level'
    Verify modal display message    '${message}'

Click attachment icon on 'CNDN level'
    Click attachment icon on 'CNDN level' to open modal
    Verify modal exist with header  'Credit / Debit Note Attachment :'

Click attachment icon on 'Invoice level'
    Click first attachment icon on 'Invoice level' to open modal
    Verify modal exist with header  'Invoice Attachment :'

Attachment modal display 'Note' as "${note}"
    First attachment detail has 'Note' value       ${note} 

Attachment modal display checked 'Send To Supplier'
    First attachment detail has 'Send To Supplier' checked mark 

Attachment modal hide 'Note' field
    First attachment detail has no 'Note' field    

Verify the 'Credit/Debit Note' Rejected Status should be correctly witn note "${note}"
    [Documentation]    Verify the credit/debit note when credit/debit note status equal 'Rejected' from approver level 1
                ...    Verify on approver level 1 should be "Rejected"
                ...    Verify note on approver level 1    
                ...    Verify on approver level 2 should be "Suspend"

    CNDN Status on approve level1 should be displayed 'Rejected' 
    Note should be displayed correct   ${note}
    CNDN Status on approve level2 should be displayed 'Suspend'


Verify the 'Credit/Debit Note' Completed Status should be correctly
    [Documentation]    Verify the credit/debit note when status equal "Completed"
                ...    Approver level 1 should be "Approve"
                ...    Approver level 2 should be "Approver"

    CNDN Status on approve level1 should be displayed 'Approve'
    CNDN Status on approve level2 should be displayed 'Approve'

Verify the 'Credit/Debit Note' Completed Status form Closed CN/DN should be correctly   
    [Documentation]    Verify the credit/debit note when status "Completed" from action "Closed CN/DN"
                ...    Approver level 1 should be "Approver"
                ...    Approver level 2 should be "Suspend"

    CNDN Status on approve level1 should be displayed 'Approve'
    CNDN Status on approve level2 should be displayed 'Suspend'

Verify the 'Credit/Debit Note' Awaiting Approver Status on Level1 should be correctly
    [Documentation]    Verify the credeit note when status "Awaiting Approval" on approver level 1
                ...    Approver level 1 should be "Awaiting"
                ...    Approver level 2 should be "Pending"

    CNDN Status on approve level1 should be displayed 'Awaiting Approval'
    CNDN Status on approve level2 should be displayed 'Pending'

Verify the 'Credit/Debit Note' Awaiting Approver Status on Level2 should be correctly
    [Documentation]    Verify the credit/debit note when status "Awaiting" on approver level 2
                ...    Approver level 1 should be "Approver"
                ...    Approver level 2 shold be "Awaiting"

    CNDN Status on approve level1 should be displayed 'Approve'
    CNDN Status on approve level2 should be displayed 'Awaiting Approve' 
  
Verify the 'Credit/Debit Note' Pending Status should be correctly
    [Documentation]    Verify the credit/debit note when status "Pending"
                ...    Approver level 1 should be "Awaiting"
                ...    Approver level 2 should be "Pending"

    CNDN Status on approve level1 should be displayed 'Awaiting Approve'
    CNDN Status on approve level2 should be displayed 'Pending'


Verify the 'Credit/Debit Note' Awaiting Status and Approve status is Processing should be correctly
    [Documentation]    Verify the credit/debit note when status "Awaiting" on approver level 1 from Closed CN/DN
                ...    Approver level 1 should be "Awaiting"
                ...    Approver level 2 should be "Suspend"

    CNDN Status on approve level1 should be displayed 'Awaiting Approval'
    CNDN Status on approve level2 should be displayed 'Suspend'


Click on the first approval box
    [Documentation]    Click on approver box level 1 (verify document)

    Click first approver box

Click on the second approval box
    [Documentation]    Click on approver box level 1 (account payable)
    Click second approver box    

Verify the system show group approval correct on credit/debit note "${cndn_number}"
    [Documentation]    Verify approver when approver is group approver

    Verify approver user as group approver    ${cndn_number}


Verify the system show a person approval correct on credit/debit note "${cndn_number}"
    [Documentation]    Verify approver when approver is personal approver

   Verify approver user as a person    ${cndn_number}

Hint Modal is shown
    Verify Modal visibility

Modal shown correct data "${cndn_num}"
    ${msg_date}     Get data that show on information need modal from db    ${cndn_num}
    ${user_firstname}   Get firstname on information need modal from db     ${msg_date[0][2]}     ${TRUE_EID}
    Verify message,buyer name,date and time of Request from Buyer with DB       ${msg_date}     ${user_firstname}

user clicked at information icon on view CNDN page
    Click on information icon
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

Click 'X' on action bar
    Click Element    ${actions.btn_x_mark}

Verify page 'CN/DN' detail display
    Wait Until Element Is Visible    ${obj_view_cndn.lbl_section_header}    ${TIMEOUT}

Verify 'View GR Detail' modal closed
    Element Should Not Be Visible   ${gr_detail_modal.div_modal_gr_detail}

Get Invoice number from expect row in table    
    [Arguments]     ${column_name}    ${row_number}
    ${ret_col_no}=    Get column number by target column name    ${column_name}    ${cndn_detail_section.tbl_invoice_header_with_columm}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    Set Test Variable   ${ret_col_no}
    Set Test Variable    ${row_number}
    ${target_obj}=    Replace Variables in YAML file        ${cndn_detail_section.tbl_invoice_row_with_columm}
    ${invoice_number}=    Get Text    ${target_obj}
    [Return]    ${invoice_number}

Click on first row of 'Invoice' table
    [Arguments]    ${column_name}
    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${cndn_detail_section.tbl_invoice_header_with_columm}
    ${target_obj}=    Replace Variables     ${cndn_detail_section.tbl_invoice_firstrow_with_columm}
    Click Element    ${target_obj}

Click 'X' to close modal
    Wait Until Page Contains Element    ${gr_detail_modal.lbl_x_mark_to_close}    ${TIMEOUT}
    Click Element    ${gr_detail_modal.lbl_x_mark_to_close}

PONum , GRNum should be equal to DB    
    [Arguments]     ${return_po_items}
    ${items_count}=    get element count   ${gr_detail_modal.lbl_gr_data_row_po_count}
    :FOR    ${row_number}    IN RANGE    0    ${items_count}-1
    \   ${xpath_row}=    Evaluate    ${row_number} + 1
    \   ${po_locator}=  Replace Variables   ${gr_detail_modal.lbl_gr_data_row_po_num}
    \   ${gr_locator}=  Replace Variables   ${gr_detail_modal.lbl_gr_data_row_gr_num}
    \   ${po_actual}=    Get Text   ${po_locator}
    \   ${gr_actual}=    Get Text   ${gr_locator}
    \   Should Be Equal    ${return_po_items[${row_number}][0]}    ${po_actual}   
    \   Should Be Equal    ${return_po_items[${row_number}][1]}    ${gr_actual}   

GR Detail should be equal to DB    
    [Arguments]     ${return_gr_items}    
    ${items_count}=    get element count   ${gr_detail_modal.tbl_gr_data_rows}
    :FOR    ${row_number}    IN RANGE    0    ${items_count}-1
    \   ${xpath_row}=    Evaluate    ${row_number} + 1
    \   ${no_locator}=  Replace Variables   ${gr_detail_modal.lbl_gr_data_row_no}
    \   ${desc_locator}=    Replace Variables   ${gr_detail_modal.lbl_gr_data_row_desc}
    \   ${unit_locator}=    Replace Variables   ${gr_detail_modal.lbl_gr_data_row_unit}
    \   ${inv_amt_locator}=     Replace Variables   ${gr_detail_modal.lbl_gr_data_row_inv_amt}
    \   ${cndn_amt_locator}=    Replace Variables   ${gr_detail_modal.lbl_gr_data_row_cndn_amt}           
    \   ${no_actual}=    Get Text    ${no_locator}
    \   ${desc_actual}=    Get Text    ${desc_locator}
    \   ${unit_actual}=    Get Text    ${unit_locator}
    \   ${invoice_amt_actual}=    Get Text    ${inv_amt_locator}
    \   ${cndn_amt_actual}=    Get Text    ${cndn_amt_locator}
    \   ${desc_expect}=    Replace String    ${return_gr_items[${row_number}][3]}    ${SPACE * 2}    ${SPACE}
    \   Should Be Equal as strings   ${return_gr_items[${row_number}][2]}    ${no_actual}   
    \   Should Be Equal as strings   ${desc_expect}                         ${desc_actual.strip()}  
    \   Should Be Equal as strings   ${return_gr_items[${row_number}][4]}    ${unit_actual}   
    \   Should Be Equal as strings    ${return_gr_items[${row_number}][5]}    ${invoice_amt_actual}   
    \   Should Be Equal as strings    ${return_gr_items[${row_number}][6]}    ${cndn_amt_actual}   

Verify label should display on header section in 'View Credit / Debit Note' page
    [Arguments]    ${expected_message}    
    Element Should Contain    ${obj_view_cndn.lbl_section_header}    ${expected_message}    

Verify label should display on detail section in 'View Credit / Debit Note' page
    [Arguments]    ${expected_message}    
    Element Should Contain    ${obj_view_cndn.lbl_section_under}    ${expected_message}   

Get CNDN Header value to list
    ${Status}=      Get Text    ${obj_view_cndn.lbl_data_Status}
    ${CNDNNumwithtitle}=    Get Text    ${obj_view_cndn.lbl_data_CNDNNumwithtitle}
    ${BuyerName}=           Get Text    ${obj_view_cndn.lbl_data_BuyerName}
    ${SupplierName}=        Get Text    ${obj_view_cndn.lbl_data_SupplierName}
    ${Created_date}=        Get Text    ${obj_view_cndn.lbl_data_Created_date}
    ${Reference_no}=        Get Text    ${obj_view_cndn.lbl_data_Reference_no}
    ${Duedate}=             Get Text    ${obj_view_cndn.lbl_data_Duedate}
    ${PaymentLocation}=     Get Text    ${obj_view_cndn.lbl_data_PaymentLocation}
    ${CNDNtotal}=           Get Text    ${obj_view_cndn.lbl_data_CNDNtotal}
    ${Currency}=            Get Text    ${obj_view_cndn.lbl_data_Currency}
    @{list}    Create List
    ${dictionary_value}=    Create Dictionary    Status=${Status}    CNDNNumwithtitle=${CNDNNumwithtitle}   BuyerName=${BuyerName}    SupplierName=${SupplierName}     Created_date=${Created_date}   Reference_no=${Reference_no}     Duedate=${Duedate}     PaymentLocation=${PaymentLocation}      CNDNtotal=${CNDNtotal}     Currency=${Currency}        
    Append To List    ${list}    ${dictionary_value}
    [Return]    ${list}   

Get CNDN Detail value to list
    ${Notefromsupplier}=    Get Text    ${obj_view_cndn.lbl_data_Notefromsupplier}
    ${CNDNNum}=             Get Text    ${obj_view_cndn.lbl_data_CNDNNum}
    ${CNDNDate}=            Get Text    ${obj_view_cndn.lbl_data_CNDNDate}
    ${TaxInvoiceNum}=       Get Text    ${obj_view_cndn.lbl_data_TaxInvoiceNum}
    ${TaxInvoiceDate}=      Get Text    ${obj_view_cndn.lbl_data_TaxInvoiceDate}
    ${ExcludeVat}=          Get Text    ${obj_view_cndn.lbl_data_ExcludeVat}
    ${Vat}=                 Get Text    ${obj_view_cndn.lbl_data_Vat}
    ${VatBaseAmount}=       Get Text    ${obj_view_cndn.lbl_data_VatBaseAmount}
    ${IncludeVat}=          Get Text    ${obj_view_cndn.lbl_data_IncludeVat}
    @{list}   Create List
    ${dictionary_value}=    Create Dictionary    Notefromsupplier=${Notefromsupplier}    CNDNNum=${CNDNNum}    CNDNDate=${CNDNDate}   TaxInvoiceNum=${TaxInvoiceNum}    TaxInvoiceDate=${TaxInvoiceDate}   ExcludeVat=${ExcludeVat}     Vat=${Vat}     VatBaseAmount=${VatBaseAmount}      IncludeVat=${IncludeVat}      
    Append To List    ${list}    ${dictionary_value}
    [Return]    ${list}   

Get CNDN Invoice value to list
    ${rowCount}     Get Element Count   ${cndn_detail_section.tbl_invoice_row_count}
    @{list}   Create List
    :FOR    ${row}    IN RANGE    1    ${rowCount} + 1
    \   ${no_locator}=              Replace Variables   ${obj_view_cndn.lbl_data_No}
    \   ${invoice_locator}=         Replace Variables   ${obj_view_cndn.lbl_data_InvoiceNum}
    \   ${invoice_amt_locator}=     Replace Variables   ${obj_view_cndn.lbl_data_InvoiceAmount}
    \   ${cndn_amt_locator}=        Replace Variables   ${obj_view_cndn.lbl_data_CNDNAmount}
    \   ${No}=              Get Text    ${no_locator}
    \   ${InvoiceNum}=      Get Text    ${invoice_locator}
    \   ${InvoiceAmount}=   Get Text    ${invoice_amt_locator}
    \   ${CNDNAmount}=      Get Text    ${cndn_amt_locator}
    \   ${dictionary_inv}=    Create Dictionary    Linenum=${No}    InvoiceNum=${InvoiceNum}   InvoiceAmount=${InvoiceAmount}    CNDNAmount=${CNDNAmount}
    \   Append To List    ${list}    ${dictionary_inv}
    [Return]    ${list}   

Verify no 3 fields is hidden from 'View Credit/Debit note' screen 
    [Arguments]    ${label_1}    ${label_2}    ${label_3}
    Element Should Not Contain    ${obj_view_cndn.lbl_section_header}    ${label_1}
    Element Should Not Contain    ${obj_view_cndn.lbl_section_header}    ${label_2}
    Element Should Not Contain    ${obj_view_cndn.lbl_section_header}    ${label_3}    

Verify Green attachment icon display in 'CNDN level'    
    Element should be visible       ${obj_view_cndn.icn_noti_green}

Verify Green attachment icon display in 'Invoice level' at first row   
    Element should be visible       ${cndn_detail_section.icn_noti_green_firstrow}

Verify attachment icon display in 'CNDN level'
    Element should be visible       ${obj_view_cndn.icn_attachment}

Verify attachment icon display in 'Invoice level' at first row
    Element should be visible       ${cndn_detail_section.icn_attachment_firstrow}

Verify modal display message    
    [Arguments]    ${message}
    ${detail_msg}=    Replace variables   ${attachment_modal.lbl_detail_msg}
    Element should be visible       ${detail_msg}

Click attachment icon on 'CNDN level' to open modal
    Click element       ${obj_view_cndn.icn_attachment}

Click first attachment icon on 'Invoice level' to open modal
    Click element       ${cndn_detail_section.icn_attachment_firstrow}

Verify modal exist with header   
    [Arguments]    ${message}
    ${modal_header}=    Replace variables   ${attachment_modal.lbl_header_txt}
    Element should be visible   ${modal_header} 

First attachment detail has 'Note' value       
    [Arguments]    ${note}
    Element text should be      ${attachment_modal.lbl_firstrow_note}        ${note}

First attachment detail has 'Send to supplier' checked mark   
    Element should be visible      ${attachment_modal.lbl_firstrow_send_to_supplier}

First attachment detail has no 'Note' field
    Element should not be visible      ${attachment_modal.lbl_firstrow_note_msg}

Click 'X' to close attachment modal
    Click element       ${attachment_modal.btn_close}

Click history button
    [Documentation]    Click button 'History' at the manage view credit/debit note detail
    
    Wait until loading complete
    Wait Until Element Is Visible    ${actions.btn_history}    ${TIMEOUT}
    Click Element    ${actions.btn_history}    


############################################################################################
############################################################################################    
############################################################################################
Note should be displayed correct    
    [Arguments]    ${expected_text}
    [Documentation]    Verify note from approver should correct

    Wait Until Element Is Visible    ${box1_approval.ico_note}    ${TIMEOUT}   
    Click Element    ${box1_approval.ico_note}    
    Wait Until Element Is Visible    ${box1_approval.txtarea_note}    ${TIMEOUT}   
    ${actual_text}=    Get Text    ${box1_approval.txtarea_note}   
    Should Be Equal As Strings    ${expected_text}    ${actual_text}

CNDN Status on approve level1 should be displayed 'Approve'
    [Documentation]    Verify credit/debit note status icon when credit/debit note status equal 'Approve'

    Wait Until Element Is Visible    ${box1_approval.ico_approve}    ${TIMEOUT}   
    Element Should Be Visible    ${box1_approval.ico_approve}     message=Approved icon show on approve level1

CNDN Status on approve level1 should be displayed 'Awaiting Approve'
    [Documentation]    Verify credit/debit note status when credit/debit note status equal 'Awaiting Approve'

    Wait Until Element Is Visible    ${box1_approval.ico_awaiting_approve}    ${TIMEOUT}    
    Element Should Be Visible    ${box1_approval.ico_awaiting_approve}    message=Awaiting Approved icon show on approve level1

CNDN Status on approve level1 should be displayed 'Rejected'    
    [Documentation]    Verify creditdebit note stattus when credit/debit note status equal 'Rejected'

    Wait Until Element Is Visible    ${box1_approval.ico_reject}    ${TIMEOUT}    
    Element Should Be Visible    ${box1_approval.ico_reject}    message=Awaiting Approved icon show on approve level1

CNDN Status on approve level2 should be displayed 'Suspend'
    [Documentation]    Verify credit/debit note status when previous approver choosed 'Rejected' credit/debit note 

    Wait Until Element Is Visible    ${box2_approval.ico_suspend}    ${TIMEOUT}   
    Element Should Be Visible    ${box2_approval.ico_suspend}    message=Suspend icon show on approve level2

CNDN Status on approve level2 should be displayed 'Awaiting Approve'
    [Documentation]    Verify credit/debit note status when previous approver choosed 'Approve' credit/debit note

    Wait Until Element Is Visible    ${box2_approval.ico_awaiting}    ${TIMEOUT}    
    Element Should Be Visible    ${box2_approval.ico_awaiting}    message=Awaiting Approved icon show on approve level2

CNDN Status on approve level2 should be displayed 'Pending'
    [Documentation]    Verify credit/debit note status when previous approver status equal 'Awaiting Approve'

    Wait Until Element Is Visible    ${box2_approval.ico_pending}    ${TIMEOUT}     
    Element Should Be Visible    ${box2_approval.ico_pending}    message=Suspend icon show on approve level2

CNDN Status on approve level2 should be displayed 'Approve'
    [Documentation]    Verify creddit/debit note status when approver level 2 choose 'Approve' credit/debit note

    Wait Until Element Is Visible    ${box2_approval.ico_approve}    ${TIMEOUT}   
    Element Should Be Visible   ${box2_approval.ico_approve}     message=Approved icon show on approve level2    

Click first approver box
    [Documentation]    Click first approver box in UI  

    Wait Until Element Is Visible    ${box1_approval.lst_box}    ${TIMEOUT}   
    Click Element    ${box1_approval.lst_box}

Click second approver box   
    [Documentation]    Clicl second approver box in UI screen

    Wait Until Element Is Visible    ${box2_approval.lst_box}    ${TIMEOUT}   
    Click Element    ${box2_approval.lst_box}



Verify approver user as group approver
    [Documentation]    Verify approver in the Group Approver
                ...    Compare data in UI with database

    [Arguments]    ${cndn_number}   
    ${group_approver_ui}    Get group approver from ui
    ${group_approver_db}    Get group approver from db    ${cndn_number}   

    List should be equal as    ${group_approver_db}    ${group_approver_ui}


Verify approver user as a person
    [Documentation]    Verify approver when approver is person
                ...    Compare by UI and DB

    [Arguments]    ${cndn_number}
    
    ${person_approver_ui}    Get person approver from ui 
    ${person_approver_db}    Get person approver from db    ${cndn_number}

    List should be equal as   ${person_approver_db}    ${person_approver_ui}

Get approver name
    [Documentation]    Get approver name from Group Approver

    Wait Until Element Is Visible    ${box1_approval.approver.firstname}  
    ${approver_firstname}=    Get Text    ${box1_approval.approver.firstname} 
    ${approver_lastname}=    Get Text    ${box1_approval.approver.lastname}  
    ${approver_name}=    CATENATE    ${approver_firstname}    ${approver_lastname}
    
    ${approver}    Set Variable    ${approver_name.strip()}
    
    Return From Keyword    ${approver}

Get approver email
    [Documentation]    Get approver email from Group Approver

    Wait Until Element Is Visible     ${box1_approval.approver.email}    ${TIMEOUT} 
    ${approver_email}=    Get Text    ${box1_approval.approver.email}

    Return From Keyword    ${approver_email}

Get approver tel number    
    [Documentation]    Get approver telephone number from Group Approver

    Wait Until Element Is Visible    ${box1_approval.approver.tel} 
    ${approver_tel}=    Get Text    ${box1_approval.approver.tel} 

    Return From Keyword    ${approver_tel}

Get person approver from ui     
    [Documentation]    Get approver detail from UI when approver is a person
                ...    Include name. email and telephone

    ${approver_name}=    Get approver name
    ${approver-email}=    Get approver email
    ${approver_tel}=    Get approver tel number

    @{list}    Create List
    Append To List    ${list}    ${approver_name},${approver-email},${approver_tel}

    Return From Keyword    ${list}

Get group approver from ui
    [Documentation]    Get group approver detail from ui include name, email and tel no.
    @{list}    Create List

    ${index_num}=    Get Element Count    ${box2_approval.approver.all_group} 

    :FOR    ${index}    IN RANGE    1    ${index_num}+1
        @{detail}    Create List

        ${name_locator}    Replace Variables    ${box2_approval.approver.name}
        ${email_locator}    Replace Variables    ${box2_approval.approver.email}
        ${tel_locator}    Replace Variables    ${box2_approval.approver.tel}

        ${name}    Get Text    ${name_locator}
        ${email}    Get Text    ${email_locator}
        ${tel}    Get Text    ${tel_locator}

        Append To List    ${detail}    ${name}
        Append To List    ${detail}    ${email}
        Append To List    ${detail}    ${tel}
        
        Append To List    ${list}    ${detail}
    END

    Return From Keyword    ${list}
       

Get person approver from db    
   [Arguments]    ${cndn_number}
   [Documentation]    Get a person approver detail from database 

   @{list}    Create List

   ${query_string}=    Prepare query get person approver   ${cndn_number}
   ${approver_detail}=    eInvoice Execute SELECT query string    ${query_string}
   Append To List    ${list}    ${approver_detail}[0][0],${approver_detail}[0][1],${approver_detail}[0][2]  

   Return From Keyword    ${list}

Get group approver from db   
    [Arguments]    ${cndn_number}
    [Documentation]    Get group approver detail from database
                ...    Include name, email and telephone no.

    @{list}    Create List

    Get buyermpid and buyerid vie eid

    ${query_string}=    Prepare query get group approver    ${cndn_number}
    ${approver_detail}=    eInvoice Execute SELECT query string    ${query_string}

    ${len}=    Get Length    ${approver_detail}
    :FOR    ${index}    IN RANGE    0    ${len}
        @{detail}    Create List
        Append To List    ${detail}    ${approver_detail}[${index}][0]   
        Append To List    ${detail}    ${approver_detail}[${index}][1]
        Append To List    ${detail}    ${approver_detail}[${index}][2]

        Append To List    ${list}    ${detail}  
    END

    Return From Keyword    ${list}

Verify Modal visibility
    Wait Until Element Is Visible   ${modal_information_need.modal}

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