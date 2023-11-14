*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
### Setup ###
Test teardown    Reload Page

*** Test Cases ***
"Approve CN/DN" display all "Credit / Debit Note" that wait to approve by logged in account
    [Tags]      regression      high    web    DB    TC_eINVOICE_02445   TC_eINVOICE_02446    TC_eINVOICE_02448     Ready
    [Documentation]  Verify data display correctly meet to condition
    Given Click menu cn/dn
    and Go to menu Approve CN/DN
    When Search Approval CN/DN with status "Awaiting"
    Then Result table display CN/DN with "Awaiting"
    and Result table display "Awaiting" status item sorting by 'Received Date' as DESC

Column "CN/DN Number" shows icon "Tax Invoice" when has tax invoice and show balloon message "Tax Invoice" when mouse over icon
    [Tags]      regression      high    web    DB    TC_eINVOICE_02449    TC_eINVOICE_02450     Ready1
    [Documentation]  Verify icon is display if there is Tax Invoice
    Given Click menu cn/dn
    and Go to menu Approve CN/DN
    When Search Approval CN/DN with status "Awaiting"
    and Click icon 'tax filter' in column 'CN/DN Number'
    and Select "With Tax Invoice" in dropdown list
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}" 
    and Click expand CN/DN for first row           
    Then Result table display CN/DN with "Awaiting"
    and There is icon 'Tax Invoice' in column 'CN/DN Number'  
    and Verify fields expansion CN/DN should show all detail correctly   

"Buyer Reference" number is shown when there is value in CN/DN
    [Tags]      regression      high    web    DB    TC_eINVOICE_02451     Ready
    [Documentation]  Verify "Buyer Reference" is generated and display.
                ...     *** Always generated after approved CN/DN
    Given Click menu cn/dn
    and Go to menu Approve CN/DN
    and Search CN/DN by CN/DN Number "dontusemycndn3"
    and Click expand CN/DN for first row
    Then 'Buyer Referance' number "BLN1091-19000002-001" is display in column "CN/DN Number"    
    and 'Buyer Referance' number "BLN1091-19000002" is display next to 'Referance Number' in CN/DN expansion
    and CN/DN expansion display fields "Reference No.", "Invoice Number", "PO Number​", "GR Number", "Cost Center", "No." and "Item Name"

"Cost Center" column display properly 
    [Tags]      regression      high    web    DB    TC_eINVOICE_02452     Ready
    [Documentation]  Verify "Cost Center" display as DB configulation in case customer site is "TRUE"
    Given Click menu cn/dn
    and Go to menu Approve CN/DN
    When Search Approval CN/DN with status "Awaiting"
    Then Result table display field name "Cost Center"

*** Keywords ***
Search CN/DN by CN/DN Number "${CNDNNum}"
     Search CN/DN with search keyword    ${CNDNNum}

Set one record data to has CN/DN Status "${cndn_status}" for account "${logged_in_account}" in DB
    ${cndn_number}=  Search first 'CN/DN' data row in DB that under target account approve authorize    ${logged_in_account}
    Set target 'CN/DN Number' to has status    ${cndn_number}    ${cndn_status}

Result table display CN/DN with "${cndn_status}" 
    Result table display data and has only target status    ${cndn_status}
    
Result table display "${cndn_status}" status item sorting by 'Received Date' as DESC
    ${db_results}=  Get result in DB for status    ${cndn_status}
    Result table data should be equal to DB data    ${db_results}

Set all record data to NO any CN/DN Status "Approved", "Awaiting", "Processing", "Rejected" for account "${logged_in_account}" in DB
    ${origin_approval_group}=  Set target account to be in target approval group    ${logged_in_account}    Z
    ${cndn_numbers}=  Get all 'CN/DN number' data row in DB that under target account approve authorize    ${logged_in_account}
    Set all 'CN/DN number' approver to be NULL    ${cndn_numbers}
    Set target 'CN/DN Number' to has status    ${cndn_number}    ${cndn_status}
    Set Test Variable    ${origin_approval_group}

Set all 'CN/DN nuber' status under "${logged_in_account}" to be origin status
    Set target account to be in target approval group    ${logged_in_account}    ${origin_approval_group}

No result table display CN/DN and show messsage "${no_result_message}"
    'Approve CN/DN' result table doesn't exist
    Target message display on 'Approve CN/DN'    ${no_result_message}

Set 'Tax Invoice' for CN/DN first row for account "${logged_in_account}" in DB
    ${cndn_number}=  Get 'CN/DN Number' from first row
    Set 'Tax Invoice' to target 'CN/DN Number'    ${cndn_number}

Click expand CN/DN for first row
    Click on expand arrow on first row of table 'Approve CN/DN'

There is icon 'Tax Invoice' in column 'CN/DN Number'
    There is icon 'Tax Invoice' in column 'CN/DN Number' For First Row

Verify fields expansion CN/DN should show all detail correctly
    Verify first row in table fields expansion CN/DN should show all detail correctly

Set one record data to has CN/DN status "${cndn_status}" and 'Buyer Referance' number "${buyer_ref}" for account "${logged_in_account}" in DB
    ${cndn_number}=  Search first 'CN/DN' data row in DB that under target account approve authorize    ${logged_in_account}
    Set target 'CN/DN Number' to has status    ${cndn_number}    ${cndn_status} 
    Set target 'CN/DN Number' to has 'Buyer Referance'    ${cndn_number}    ${buyer_ref}

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

Result table display field name "${cost_center_text}"
    Field 'Cost Center' display    ${cost_center_text}

Result table display data and has only target status    
    [Arguments]    ${cndn_status} 
    Table CN/DN should have at least one row
    Verify 'CN/DN' at column display value correctly    Status      ${cndn_status} 

Result table data should be equal to DB data    
    [Arguments]    ${db_results} 
    ${Frontend_list}=   Set Approval list from frontend to list
    ${DB_list}=     Set Approval list db results to list   ${db_results}
    Lists Should Be Equal   ${Frontend_list}      ${DB_list}    ignore_order=True

Click on expand arrow on first row of table 'Approve CN/DN'
    ${row_num}      set variable    1
    ${btn_expand_locator}   Replace variables       ${obj_table.tbl_expand_button} 
    Mouse over      ${btn_expand_locator}
    Click element   ${btn_expand_locator}

Verify first row in table fields expansion CN/DN should show all detail correctly
    ${cndn_id}=     Query CNDNID from 'CNDN' in DB      '${cndn_no}'
    Verify expansion 'Invoice Num' 'PO Num' 'GR Num'    ${cndn_id}
    # Verify expansion PO Detail      ${cndn_id} 

Verify expansion 'Invoice Num' 'PO Num' 'GR Num'
    [Arguments]     ${cndn_id}
    ${sql_inv_po_gr}=   Get query string for SELECT 'CNDNItemDetail' where with 'CNDNID'    ${cndn_id}
    ${return_inv_po_gr_list}=  eInvoice Execute SELECT query string    ${sql_inv_po_gr}   
    ${db_inv_length}=  Get Length      ${return_inv_po_gr_list}
    ${row_num}=     Set variable    1
    ${obj_table.tbl_inv_count}  Replace variables   ${obj_table.tbl_inv_count}
    ${obj_table.tbl_po_count}   Replace variables   ${obj_table.tbl_po_count}
    ${front_inv_list}=      Get element count   ${obj_table.tbl_inv_count}
    ${front_po_list}=      Get element count   ${obj_table.tbl_po_count}
    Should Be Equal     ${db_inv_length}        ${front_inv_list}
    Should Be Equal     ${db_inv_length}        ${front_po_list}

Verify expansion PO Detail    
    [Arguments]     ${cndn_id}
    ${sql_detail_po}=   Get query string for SELECT 'CNDNItemDetail' where with 'CNDNID' for PO Detail    ${cndn_id}
    ${return_po_detail}=  eInvoice Execute SELECT query string    ${sql_detail_po} 
    ${row_num}=     Set variable    1
    ${db_po_detail_length}=  Get Length      ${return_po_detail}
    ${obj_table.tbl_detail_count}   Replace variables   ${obj_table.tbl_detail_count}
    ${front_po_detail_list}=      Get element count   ${obj_table.tbl_detail_count}
    Should Be Equal     ${front_po_detail_list}        ${db_po_detail_length}

First row contain target data    
    [Arguments]    ${buyer_ref}    ${column_number}
    ${ret_col_no}   set variable    ${column_number}
    ${locator}=     Replace variables   ${obj_table.tbl_cndn_firstrow_data_with_columm}
    element should contain      ${locator}      (${buyer_ref})

Buyer referance display in first expansion row of 'CN/DN'    
    [Arguments]    ${buyer_ref}   
    ${row_num}  set variable    1
    ${refno_locator}    Replace variables   ${obj_table.tbl_refno}
    ${Refno}    Get Text    ${refno_locator}
    @{Ref} =  Split String    ${Refno}      ${SPACE}
    Should be equal     ${Ref}[1]   (${buyer_ref})

First row expansion contain target field
    [Arguments]    ${text}
    ${row_num}  set variable   1
    ${expand_locator}   Replace variables   ${obj_table.tbl_expandsion_with_row}
    Element Should Contain      ${expand_locator}   ${text}   
    
Field 'Cost Center' display    
    [Arguments]    ${cost_center_text}    
    Element should contain      ${obj_table.tbl_cndn_result_header_text}     ${cost_center_text}