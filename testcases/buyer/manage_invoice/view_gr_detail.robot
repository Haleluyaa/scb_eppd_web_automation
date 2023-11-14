*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource

### Third party resource ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource

### Page keyword releted ###
Resource    ../../../keywords/web/invoice/view_invoice_grdetail_keywords.resource
Resource    ../../../keywords/web/invoice/view_invoice_detail_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/database/invoice/view_invoice_grdetail_keywords.resource

### Test Suite Data ###
Variables    ../../../resources/testdata/${ENV}/invoice/invoice_status.yaml

Test Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VIEW_1}" and "${TRUE_PASSWORD}"
Test Teardown    Clear all cookie and closed browser


*** Test Cases ***
To verify the system display gr detail items correctly on manage site
    [Tags]   Web  ManageInvoice  Buyer  BuyerViewInvoiceStatus  ViewInvoice  DB   TC_eINVOICE_01262     TC_eINVOICE_02415    regression
    [Documentation]    Verify gr detail item display correct compare with DB

    Given Go to Manage invoice page by url
    And Go to Manage invoice page by url
    And Search invoice on approve list by keyword equal "${VIEW_GR_OFFLINE.INVOICE_NUM}" and invoice status equal "All Status" 
    And Go to invoice status detail page
    When Click on the first row non gr of PO Detail in view invoice page
    Then Verify gr detail in display modal on "${VIEW_GR_ONLINE.INVOICE_NUM}" and "${VIEW_GR_ONLINE.GR_NUM}"
