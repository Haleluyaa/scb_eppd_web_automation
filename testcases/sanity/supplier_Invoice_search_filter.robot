***Settings***
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
### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml

Suite Setup    Go to einvoice website via SWW with "${SWW_USER}" and "${SWW_PASS}"
Suite Teardown    Clear all cookie and closed browser
Test Teardown   Reload page


*** Test Cases ***
Verify default search and filter selection and value
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that default of status filter is "All Status" and default of filter is "Invoice Number"
    When search filter is visible
    Then default filter should be 'Invoice Number' and status filter should be 'All Status'

Verify that filter by status 'Awaiting Approval' is working​
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user select status "Awaiting Approval" filter is working​ properly
    When user select status filter "${STATUS.AWAITING_APPROVAL}"
    Then system should display all Invoice that have status "${STATUS.AWAITING_APPROVAL}" 

Verify that filter by status 'Pending' is working​
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user select status "Pending" filter is working​ properly
    When user select status filter "${STATUS.PENDING}"
    Then system should display all Invoice that have status "${STATUS.PENDING}"

Verify that filter by status 'Rejected' is working​
    [Tags]    Ready    Regression   Sanity    Web    High     
    [Documentation]    To verify that when user select status "Rejected" filter is working​ properly
    When user select status filter "${STATUS.REJECTED}"
    Then system should display all Invoice that have status "${STATUS.REJECTED}"

Verify that filter by status 'Completed' is working​
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user select status "Completed" filter is working​ properly
    When user select status filter "${STATUS.COMPLETED}"
    Then system should display all Invoice that have status "${STATUS.COMPLETED}"

Verify that filter by status 'Expired' is working​
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user select status "Expired" filter is working​ properly
    When user select status filter "${STATUS.EXPIRED}"
    Then system should display all Invoice that have status "${STATUS.EXPIRED}"

Verify that filter by status 'Document Return' is working​
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user select status "Document Return" filter is working​ properly
    When user select status filter "${STATUS.DOCUMENT_RETURN}"
    Then system should display all Invoice that have status "${STATUS.DOCUMENT_RETURN}"

Verify that filter by status 'Cancelled' is working​
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user select status "Cancelled" filter is working​ properly
    When user select status filter "${STATUS.CANCELLED}"
    Then system should display all Invoice that have status "${STATUS.CANCELLED}"

# Verify that filter by status 'Partially Paid' is working​
#     [Tags]    Ready    Regression   Sanity    Web    High    
#     [Documentation]    To verify that when user select status "Partially Paid" filter is working​ properly
#     When user select status filter "${STATUS.PARTIALLY_PAID}"
#     Then system should display all Invoice that have status "${STATUS.PARTIALLY_PAID}"

# Verify that filter by status 'Fully Paid' is working​
#     [Tags]    Ready    Regression   Sanity    Web    High    
#     [Documentation]    To verify that when user select status "Fully Paid" filter is working​ properly
#     When user select status filter "${STATUS.FULLY_PAID}"
#     Then system should display all Invoice that have status "${STATUS.FULLY_PAID}"

# Verify that filter 'Invoice Number' is working 
#     [Tags]    Regression   Sanity    Web    High
#     [Documentation]    To verify that when user using "Invoice Number​" filter is working​ properly
#     When User select filter "Invoice number" and enter "${INVOICE_NUMBER}" in search textbox
#     Then system should display all Invoice that have Invoice Number "${INVOICE_NUMBER}"

# Verify that filter 'Reference No.​' is working 
#     [Tags]    Regression   Sanity    Web    High    
#     [Documentation]    To verify that when user using "Reference No.​" filter is working​ properly
#     When user select Reference Number​ filter and enter Reference Number​ "${REFERENCE_NUMBER}" in search textbox
#     Then system should display all Invoice that have Reference Number​ "${REFERENCE_NUMBER}"

# Verify that filter 'Buyer​' is working 
#     [Tags]    Regression   Sanity    Web    High   
#     [Documentation]    To verify that when user using "Buyer​" filter is working​ properly
#     When user select Buyer filter and enter Buyer​ name "${BUYER_NAME}" in search textbox
#     Then system should display all Invoice that have Buyer​ name "${BUYER_NAME}"

# Verify that filter 'PO Number' is working 
#     [Tags]    Regression   Sanity    Web    High    
#     [Documentation]    To verify that when user using "PO Number" filter is working​ properly
#     When user select PO Number filter and enter PO Number "${PO_NUMBER}" in search textbox
#     Then system should display all Invoice that have PO Number "${PO_NUMBER}"

Verify default calendar selection
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that default of calendar filter is "Any time"
    Given search filter is visible 
    When user click calendar in search textbox
    Then default calendar selection should be 'Any Time'

Verify that calendar 'Created Date' Filter is working
    [Tags]    Ready   Regression   Sanity    Web    High    
    [Documentation]    To verify that when user using calendar's "Created Date" filter is working​ properly
    Given search filter is visible
    When user click calendar in search textbox 
    and select 'Created Date' date range 
    Then selected calendar selection should be 'Created Date'

Verify that calendar 'Due Date' Filter is working
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that when user using calendar's "Due Date" filter is working​ properly
    Given search filter is visible
    When user click calendar in search textbox 
    and select 'Due Date' date range 
    Then selected calendar selection should be 'Due Date'

