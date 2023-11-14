*** Setting ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../keywords/web/common/buyer_menu_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/invoice/buyer_manage_invoice_list_keywords.resource
Resource    ../../keywords/web/invoice/invoice_history_keywords.resource
Resource    ../../keywords/web/invoice/buyer_manage_invoice_view_detail_keywords.resource
Resource    ../../keywords/web/invoice/view_invoice_grdetail_keywords.resource

### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml


Suite Setup     Run Keywords    Go to einvoice website from EP via "${MTL_EP_WEB}" site with "${MTL_VERIFY}" and "${MTL_PASSWORD}"
                          ...   Go to Manage invoice page by url
                          ...   Change language 'EN'

Suite Teardown     Run Keywords    Logout from eInvoice
                            ...    Delete All Cookies
                            ...    Close browser
*** Test Cases ***
Buyer can view gr and show gr detail correctly
    [Tags]    Sanity    Ready    ViewGrDetail
    Given User get invoice data for validate from invoice list invoice on row "1"
    And User click on specificed invoice row "1" at column "2" 
    And Prepare validate PO Number and GR Number on row number "1"
    And Click on PO Number at the first row
    Then Modal view gr detail should be show and display correct data "gr_detail_format"

 