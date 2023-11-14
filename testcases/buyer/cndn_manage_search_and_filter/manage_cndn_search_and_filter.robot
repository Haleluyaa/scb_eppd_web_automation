***Settings***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
#Resource    ../../../keywords/web/cn_dn/manage_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Variables   ../../../resources/testdata/${env}/common/login.yaml

### Setup ###
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test teardown   Reload page                            

*** Test Cases ***
Verify default search and filter selection and value
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that default of status filter is "All Status" and default of filter is "CN/DN number"
    Given Go to menu manage CN/DN
    When search filter is visible
    Then default filter should be 'CN/DN' and status filter should be 'All Status'

Verify that filter by status 'Awaiting Approval' is working​
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user select status "Awaiting Approval" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.AWAITING_APPROVAL}"
    Then system should display all CN/DN that have status "${STATUS.AWAITING_APPROVAL}" 

Verify that filter by status 'Pending' is working​
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user select status "Pending" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.PENDING}"
    Then system should display all CN/DN that have status "${STATUS.PENDING}"

Verify that filter by status 'Rejected' is working​
    [Tags]    Ready    Regression    Web    High     
    [Documentation]    To verify that when user select status "Rejected" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.REJECTED}"
    Then system should display all CN/DN that have status "${STATUS.REJECTED}"

Verify that filter by status 'Completed' is working​
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user select status "Completed" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.COMPLETED}"
    Then system should display all CN/DN that have status "${STATUS.COMPLETED}"

Verify that filter by status 'Expired' is working​
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user select status "Expired" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.EXPIRED}"
    Then system should display all CN/DN that have status "${STATUS.EXPIRED}"

Verify that filter by status 'Document Return' is working​
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user select status "Document Return" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.DOCUMENT_RETURN}"
    Then system should display all CN/DN that have status "${STATUS.DOCUMENT_RETURN}"

Verify that filter by status 'Cancelled' is working​
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user select status "Cancelled" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select status filter "${STATUS.CANCELLED}"
    Then system should display all CN/DN that have status "${STATUS.CANCELLED}"

Verify that filter 'CN/DN Number' is working 
    [Tags]    Ready    Regression    Web    High
    [Documentation]    To verify that when user using "CN/DN Number​" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select CN/DN search filter and enter CN/DN number "${CNDN_NUMBER}" in search textbox
    Then system should display all CN/DN that have CN/DN Number "${CNDN_NUMBER}"

Verify that filter 'Invoice Number​' is working 
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user using "Invoice Number" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select Invoice Number​ filter and enter Invoice Number​ "${INVOICE_NUMBER}" in search textbox
    Then system should display all CN/DN that have Invoice Number​ "${INVOICE_NUMBER}"

Verify that filter 'Reference No.​' is working 
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user using "Reference No.​" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select Reference Number​ filter and enter Reference Number​ "${REFERENCE_NUMBER}" in search textbox
    Then system should display all CN/DN that have Reference Number​ "${REFERENCE_NUMBER}"

Verify that filter 'Buyer​' is working 
    [Tags]    Ready    Regression    Web    High   
    [Documentation]    To verify that when user using "Buyer​" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select Buyer filter and enter Buyer​ name "${BUYER_NAME}" in search textbox
    Then system should display all CN/DN that have Buyer​ name "${BUYER_NAME}"

Verify that filter 'Supplier​' is working 
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user using "Supplier" filter is working​ properly
    Given Go to menu manage CN/DN
    When user select Supplier​ filter and enter Supplier​ name "${SUPPLIER_NAME}" in search textbox
    Then system should display all CN/DN that have Supplier​ name "${SUPPLIER_NAME}"

Verify default calendar selection
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that default of calendar filter is "Any time"
    Given Go to menu manage CN/DN
    When user click calendar in search textbox
    Then default calendar selection should be 'Any Time'
    
Verify that calendar 'Any time' Filter is working
    [Tags]    Ready    Regression    Web    High     
    [Documentation]    To verify that when user using calendar's "Any time" filter is working​ properly
    Given Go to menu manage CN/DN
    When user click calendar in search textbox 
    and select 'Any time' date range 
    and user select status filter "${STATUS.AWAITING_APPROVAL}"
    Then system should display all CN/DN that have status "${STATUS.AWAITING_APPROVAL}"

Verify that calendar 'Created Date' Filter is working
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that when user using calendar's "Created Date" filter is working​ properly
    Given Go to menu manage CN/DN
    When user click calendar in search textbox 
    and select 'Created Date' date range 
    and user select from date "${CNDN_FROM_DATE}" and to date "${CNDN_TO_DATE}"
    and user select status filter "${STATUS.AWAITING_APPROVAL}"
    Then system should display all CN/DN with status "${STATUS.AWAITING_APPROVAL}" and Created Date from date "${CNDN_FROM_DATE}" and to date "${CNDN_TO_DATE}"

Verify that system show 'Invalid Date' when To date is less than From date
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To verify that system shows “Invalid Date” when user select To date that is less than From date
    Given Go to menu manage CN/DN
    When user click calendar in search textbox 
    and select 'Created Date' date range 
    and user select from date "${CNDN_FROM_DATE}" and to date "${LESS_CNDN_TO_DATE}"
    Then 'Invalid date' message should be appear at to date selector

Verify that system show 'No results found.' when using invalid date filter
    [Tags]    Ready    Regression    Web    High 
    [Documentation]    To verify that system shows “No results found.” when user using invalid date filter
    Given Go to menu manage CN/DN
    When user click calendar in search textbox 
    and select 'Created Date' date range 
    and user select from date "${NO_DATA_CNDN_FROM_DATE}" and to date "${NO_DATA_CNDN_TO_DATE}"
    and click search button
    Then system should display 'No results found.'

