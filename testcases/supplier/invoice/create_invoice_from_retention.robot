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
Resource    ../../../keywords/web/invoice/supplier_create_invoice_keywords.resource
Resource    ../../../keywords/web/invoice/view_invoice_detail_keywords.resource

### Test Suite Data ###
Variables    ../../../resources/testdata/${env}/invoice/invoice.yaml

### Setup ###
Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier

Suite Teardown    Run Keywords    Delete All Cookies
                            ...    Close All browsers

***Test Cases***
User can create invoice from retention   
    [Tags]    Ready    Regression    High    Web
    [Documentation]    To verify end to end process of create invoice from retention
    ${INVOICE_NUMBER_COMPLETE_RETENTION}=   Set variable    KTRetentionBase10
    
    Given User search invoice "${INVOICE_NUMBER_COMPLETE_RETENTION}" and status "${STATUS['COMPLETED_RETENTION']}" which will be use to create invoice
    and User clicked at invoice "${INVOICE_NUMBER_COMPLETE_RETENTION}" to select invoice
    When User clicked "Invoice from Retention" button
    and User input invoice number "${INVOICE_NUMBER_FROM_RETENTION}" and input date "${INVOICE_FROM_RETENTION_DATE}"
    and set invoice amount to "1"
    and User clicked submit 
    Then System should create invoice "${INVOICE_NUMBER_FROM_RETENTION}" successfully 