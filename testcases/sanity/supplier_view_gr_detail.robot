*** Setting ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource

### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource

### Page keyword releted ###
Resource    ../../keywords/web/invoice/supplier_create_invoice_keywords.resource
Resource    ../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../keywords/web/invoice/invoice_details_keywords.resource
Resource    ../../keywords/web/invoice/view_invoice_grdetail_keywords.resource

### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml


Suite Setup    Go to einvoice website via SWW with "${SWW_USER}" and "${SWW_PASS}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close browser

*** Test Cases ***
Supplier can view gr and show gr detail correctly
    [Tags]    Sanity    Ready    ViewGrDetail

    Given Filter invoice with status "Awaiting Approval"            
    When User get invoice data for validate from invoice list invoice on row "1"  
    And User click on specificed invoice row "1" at column "5"
    And Prepare validate PO Number and GR Number from row "1"
    And Click on PO Number at the row "1"
    Then Modal view gr detail should be show and display correct data "gr_detail_format"

