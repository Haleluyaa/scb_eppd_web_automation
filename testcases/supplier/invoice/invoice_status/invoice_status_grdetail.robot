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
Resource    ../../../../keywords/web/invoice/view_invoice_detail_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../../keywords/web/invoice/view_invoice_grdetail_keywords.resource
Resource    ../../../../keywords/database/invoice/view_invoice_grdetail_keywords.resource

### Test Suite Data ###
Variables    ../../../../resources/testdata/uat/invoice/invoice_status.yaml


Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
Suite Teardown    Clear all cookie and closed browser
Test Teardown   Reload page

*** Test Cases ***
To verify supplier view gr detail modal that display No, Item Name, Unit, GR Amount, Invoice Amount and Retention in detail.
    [Tags]    TC_eINVOICE_01260    DB    Web    Supplier    Ready     SupplierInvoiceStatus    ViewGrDetail    Web    regression
    [Documentation]    Verify retention amout etc, in gr detail modal by compare value with database
    
    Given Search invoice number via input "${VIEW_GR_ONLINE.INVOICE_NUM}"
    And Go to invoice status detail page
    When Click on gr number is "${VIEW_GR_ONLINE.GR_NUM}"
    Then Verify gr detail in display modal on "${VIEW_GR_ONLINE.INVOICE_NUM}" and "${VIEW_GR_ONLINE.GR_NUM}"









    
    
