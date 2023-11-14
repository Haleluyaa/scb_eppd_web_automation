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
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/invoice/invoice_status_keywords.resource
### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml

Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VIEW_1}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close browser
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

Verify default calendar selection
    [Tags]    Ready    Regression   Sanity    Web    High    
    [Documentation]    To verify that default of calendar filter is "Any time"
    Given search filter is visible 
    When user click calendar in search textbox
    Then default calendar selection should be 'Any Time'

Verify that calendar 'Created Date' Filter is working
    [Tags]   Ready    Regression   Sanity    Web    High    
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

