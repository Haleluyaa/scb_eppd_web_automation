*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/web/invoice/create_invoice_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_details_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/invoice/create_invoice.yaml

### Setup ###
Test Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers


*** Test Cases ***
Select "Retention Amount" unit in invoice detail should work properly when select only retention "Amount" unit
    [Tags]      regression      high    web    TC_eINVOICE_02398    TC_eINVOICE_02400    TC_eINVOICE_02401    
    Given User create Invoice with buyer "${BUYER_NAME}"
    and Select all PO and Create New Invoice
    When Go to Invoice details page
    and Select all retention unit to Amount and input all amount by "${RETENTION_AMOUNT}"
    Then "Retention" column first row in create invoice page should equal to "${total_amount}"
    
Select "Retention Amount" unit in invoice detail should work properly when select both retention "%" and "Amount" unit
    [Tags]      regression      high    web    TC_eINVOICE_02398    TC_eINVOICE_02399    TC_eINVOICE_02401
    Given User create Invoice with buyer "${BUYER_NAME}"
    and Select all PO and Create New Invoice
    When Go to Invoice details page
    and Select retention unit to % and Amount and input all amount by "${RETENTION_AMOUNT}"
    Then "Retention" column first row in create invoice page should equal to "${total_amount}"
     
Retention calculate correctly when back to edit after save successfully
    [Tags]      regression      high    web    TC_eINVOICE_02404    
    Given User create Invoice with buyer "${BUYER_NAME}"
    and Select all PO and Create New Invoice
    When Go to Invoice details page
    and Select retention unit to % and Amount and input all amount by "${RETENTION_AMOUNT}"
    and "Retention" column first row in create invoice page should equal to "${total_amount}"
    and Go to Invoice details page
    and Select all retention unit to Amount and input all amount by "${RETENTION_AMOUNT}"
    Then "Retention" column first row in create invoice page should equal to "${total_amount}"
    
Error "This amount cannot be larger than the invoice amount" display when input retention amount over invoice amount  
    [Tags]      regression      high    web    TC_eINVOICE_02402    
    Given User create Invoice with buyer "${BUYER_NAME}"
    and Select all PO and Create New Invoice
    When Go to Invoice details page    
    and Select retention unit to Amount and input amount over invoice amount for first row    
    Then Error message display under field "${ERROR_AMOUNT_LARGER}"
    and When click on 'Save' still on page with error "${ERROR_AMOUNT_LARGER}"