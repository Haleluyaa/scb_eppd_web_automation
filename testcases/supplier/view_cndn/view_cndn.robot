*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Setup ###
Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
Suite Teardown    Clear all cookie and closed browser
Test teardown   Reload page

*** Test Cases ***
"View Credit/ Debit note" page shoud display data properly when click each row from "CN/DN status"
    [Tags]   regression      high    web    DB    TC_eINVOICE_02430   TC_eINVOICE_02431   TC_eINVOICE_02432
    [Documentation]  Verify new page is implemented and pass data to display on that page   
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}" 
    and Set value in DB for 'Due Date​' as "${DUE_DATE}", 'Payment Location' as "${PAYMENT_LOCATION}" and 'Note to Buyer​' as "${MESSAGE_TO_BUYER}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then Message for Header section display all expected "${MESSAGE_HEADER_SECTION}" correctly
    and Message for Credit/Debit note section display all expected "${MESSAGE_HEADER_SECTION}" correctly
    and Message for Invoice section display all expected "${MESSAGE_HEADER_SECTION}" correctly

"View Credit/ Debit note" page shoud display action top bar "Edit" properly with CN/DN status "Pending"
    [Tags]   regression      high    web    DB    TC_eINVOICE_02433
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page    
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.PENDING}"
    and Search CN/DN with status "${STATUS.PENDING}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'Edit', 'Print Cover', 'Print Billing', 'History'

"View Credit/ Debit note" page shoud display action top bar "Print Cover" properly with CN/DN status "Awaiting"
    [Tags]   regression      high    web    DB    TC_eINVOICE_02434
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.AWAITING_APPROVAL}"
    and Search CN/DN with status "${STATUS.AWAITING_APPROVAL}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'Print Cover', 'Print Billing', 'History'   

"View Credit/ Debit note" page shoud display action top bar "Print Billing" properly with CN/DN status "Completed"
    [Tags]   regression      high    web    DB    TC_eINVOICE_02435
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.COMPLETED}"
    and Search CN/DN with status "${STATUS.COMPLETED}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'Print Billing', 'History' 

"View Credit/ Debit note" page shoud display action top bar "History" properly with CN/DN status "Rejected"
    [Tags]      regression      high    web   DB    TC_eINVOICE_02436
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.REJECTED}"
    and Search CN/DN with status "${STATUS.REJECTED}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'History' 

"View Credit/ Debit note" page shoud display action top bar "History" properly with CN/DN status "Expired"
    [Tags]      regression      high    web   DB    TC_eINVOICE_02436
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.EXPIRED}"
    and Search CN/DN with status "${STATUS.EXPIRED}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'History' 

"View Credit/ Debit note" page shoud display action top bar "History" properly with CN/DN status "Returned Document​"
    [Tags]      regression      high    web    DB    TC_eINVOICE_02436
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.DOCUMENT_RETURN}"
    and Search CN/DN with status "${STATUS.DOCUMENT_RETURN}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'History' 

"View Credit/ Debit note" page shoud display action top bar "History" properly with CN/DN status "Cancelled"
    [Tags]      regression      high    web    DB    TC_eINVOICE_02436
    [Documentation]  Verify action is display with status condition
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.CANCELLED}"
    and Search CN/DN with status "${STATUS.CANCELLED}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and Action bar on top display button 'History' 

"Due Date​" ,"Payment Location" and "Note to Buyer​" should hide if data in database is NULL
    [Tags]      regression      high    web    DB    TC_eINVOICE_02437
    [Documentation]  Verify label should display on detail section in 'View Credit / Debit Note' page is heiden if has NULL value in DB    
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'Due Date​' as "${NULL_VALUE}", 'Payment Location' as "${NULL_VALUE}" and 'Note to Buyer​' as "${NULL_VALUE}"
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then 'View Credit/ Debit note' page display
    and "Due Date​", "Payment Location" and "Note to Buyer​" is hidden
