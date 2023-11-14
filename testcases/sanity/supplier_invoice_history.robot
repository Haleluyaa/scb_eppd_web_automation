*** Setting ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/database/common/common_db_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/invoice/supplier_create_invoice_keywords.resource
Resource    ../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../keywords/web/invoice/invoice_history_keywords.resource
Resource    ../../keywords/web/invoice/invoice_details_keywords.resource
### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml

Suite Setup    Go to einvoice website via SWW with "${SWW_USER}" and "${SWW_PASS}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close browser


*** Test Cases ***
Supplier view invoice history on invoice list
    [Tags]    Sanity    Ready    ViewInvoiceHistory
    [Documentation]    Verify view invoice history in this expected
                ...    - Buyer 
                ...    - Supplier
                ...    - Format date
                ...    - History detail
    Given Filter invoice with status "Awaiting Approval"            
    And User get invoice data for validate from invoice list invoice on row "1"            
    And User clicked action button on row "1" 
    When User choose invoice options "history" at row "1"  
    Then Invoice history be show correctly on header with invoice number "${TV_invoice_num}" and "${TV_buyer_name}" and "${TV_invoice_create_date}"
    And Invoice history be show correctly on detail 

    [Teardown]    Reload Page

Supplier view invoice history on invoice detail
    [Tags]    Sanity    Ready    ViewInvoiceHistory     1
    [Documentation]    Verify view invoice history in this expected
                ...    - Buyer 
                ...    - Supplier
                ...    - Format date
                ...    - History detail
    Given Filter invoice with status "Awaiting Approval"            
    When User get invoice data for validate from invoice list invoice on row "1"  
    And User click on specificed invoice row "1" at column "5"
    When User click button history 
    Then Invoice history be show correctly on header with invoice number "${TV_invoice_num}" and "${TV_buyer_name}" and "${TV_invoice_create_date}"
    And Invoice history be show correctly on detail
    
    [Teardown]    Reload Page