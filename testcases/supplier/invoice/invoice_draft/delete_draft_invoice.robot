*** Settings ***
#### Global Keyword ####
Resource    ../../../../resources/global_keyword.resource
Resource    ../../../../resources/global_lib.resource
Resource    ../../../../resources/global_var.resource

#### Common Keyword ####
Resource    ../../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../../keywords/database/common/common_db_keywords.resource

#### Page Keyword ####
Resource    ../../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_details_keywords.resource
Resource    ../../../../keywords/database/invoice/invoice_status.resource
Variables    ../../../../resources/testdata/uat/invoice/invoice_status.yaml

Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
Suite Teardown    Clear all cookie and closed browser
Test Setup    Set draft invoice on invoice number "LockByMetro/01" to active
Test Teardown   Reload page

***Test Cases***
To verify supplier user can delete invoice status draft from invoice list
    [Documentation]    Delete invoice status draft in invoice list page
    [Tags]      ready   supplier    invoice
    Given Search invoice number via input "LockByMetro/01"            
    And User clicked action button on row "1"
    When User choose invoice options "delete" at row "1"
    and Confirm delete
    Then Selected invoice "LockByMetro/01" delete draft invoice should be deleted

To verify supplier user can delete invoice status draft from invoice detail
    [Tags]      ready   supplier    invoice
    Given Search invoice number via input "LockByMetro/01"
    And User click on specificed invoice row "1" at column "5" 
    When User click button delete in invoice detail
    And User confirm deleted draft invoice
    Then Selected invoice "LockByMetro/01" delete draft invoice should be deleted