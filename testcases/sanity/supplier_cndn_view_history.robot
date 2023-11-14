*** Settings ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../keywords/web/cn_dn/cndn_history_keywords.resource
Resource    ../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../keywords/web/cn_dn/cndn_history_keywords.resource
Resource    ../../keywords/web/cn_dn/supplier_cndn_keywords.resource

### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml
### Setup ###
Suite Setup    Go to einvoice website via SWW with "${SWW_USER}" and "${SWW_PASS}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close browser
test teardown   Reload page                            

Metadata    Version    1.0
Metadata    EXECUTE_AT    %{COMPUTERNAME}   

*** Test Cases ***
Supplier view invoice history on invoice list
    [Tags]    Sanity    Ready    ViewInvoiceHistory 
    [Documentation]    Verify view invoice history in this expected
                ...    - Buyer 
                ...    - Supplier
                ...    - Format date
                ...    - History detail
    Given Supplier go to menu CN/DN            
    And Filter credit/debit note with status "Awaiting Approval"            
    And User get cndn data for validate from invoice list invoice on row "1"            
    And User clicked action button on row "1" 
    When User choose cndn options "history" at row "1"  
    Then CNDN history be show correctly on header with invoice number "${TV_cndn_num}" and "${TV_buyer_name}" and "${TV_cndn_create_date}"
    And CNDN history be show correctly on detail 

    [Teardown]    Reload Page

Supplier view invoice history on invoice detail
    [Tags]    Sanity    Ready    ViewInvoiceHistory
    [Documentation]    Verify view invoice history in this expected
                ...    - Buyer 
                ...    - Supplier
                ...    - Format date
                ...    - History detail
    Given Supplier go to menu CN/DN            
    And Filter credit/debit note with status "Awaiting Approval"            
    When User get cndn data for validate from invoice list invoice on row "1"   
    And User click on specificed invoice row "1" at column "5"
    When Click menu "History" at top right corner
    Then CNDN history be show correctly on header with invoice number "${TV_cndn_num}" and "${TV_buyer_name}" and "${TV_cndn_create_date}"
    And CNDN history be show correctly on detail 
    
    [Teardown]    Reload Page