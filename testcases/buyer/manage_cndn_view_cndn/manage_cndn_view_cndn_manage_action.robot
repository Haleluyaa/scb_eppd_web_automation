*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Variables   ../../../resources/locators/common/invoice_menu_locator.yaml
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_view_cndn_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml
Variables   ../../../resources/testdata/${env}/common/login.yaml
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml


### Setup ###
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers     
Test teardown       Run keywords    Click 'X' mark to close 'View CNDN' page    Reload page

*** Test Cases ***
Verify action button availability according to CN/DN status 'Awaiting Approval'
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status 'Awaiting Approval'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Awaiting Approval"
    When user view selected CN/DN Detail
    Then print billing button, history button should be available on view cndn page

Verify action button availability according to CN/DN status 'Pending'
    [Tags]    Ready    Regression    Web    High
    [Documentation]    To Verify action button availability according to CN/DN status 'Pending'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Pending"
    When user view selected CN/DN Detail
    Then print billing button, history button should be available on view cndn page

Verify action button availability according to CN/DN status 'Completed'
    [Tags]    Ready    Regression    Web    High
    [Documentation]    To Verify action button availability according to CN/DN status 'Completed'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Completed"
    When user view selected CN/DN Detail
    Then cancel cndn button, print billing button, history button should be available on view cndn page    

Verify action button availability according to CN/DN status 'Rejected'
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status 'Rejected'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Rejected"
    When user view selected CN/DN Detail
    Then return document button, history button should be available on view cndn page

Verify action button availability according to CN/DN status 'Expired'
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status 'Expired'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Expired"
    When user view selected CN/DN Detail
    Then history button should be available on view cndn page

Verify action button availability according to CN/DN status 'Document Return'
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status 'Document Return'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Document Return"
    When user view selected CN/DN Detail
    Then history button should be available on view cndn page    

Verify action button availability according to CN/DN status 'Cancelled'
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status 'Cancelled'
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and user select CN/DN with status "Cancelled"
    When user view selected CN/DN Detail
    Then history button should be available on view cndn page      

Verify action button "cancel cn/dn" button availability according to Buyer configuration
    [Tags]    Regression   Web    High    Ready
    [Documentation]    To Verify action button "cancel cn/dn" button availability according to Buyer configuration and CNDNtype is Offline(6)
    Given set configuration of "cancel cn/dn" button that have buyer "${TRUE_MPID}" to be available at status "Awaiting Approval" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Supplier name "${SUPPLIER_AIS}" and status 'Awaiting Approval'
    When user view selected CN/DN Detail
    Then Cancel cn/dn button is available on view cndn page

    [Teardown]      Run Keywords    Set button configuration disable    cancel cn/dn    ${TRUE_MPID}    Awaiting Approval
    ...             AND             Click 'X' mark to close 'View CNDN' page
    ...             AND             Reload page

Verify action button "return document​" button availability according to Buyer configuration
    [Tags]    Regression   Web    High    Ready
    [Documentation]    To Verify action button "return document​" button availability according to Buyer configuration and CNDNtype is Offline(6)
    Given set configuration of "return document" button that have buyer "${TRUE_MPID}" to be available at status "Pending" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Supplier name "${SUPPLIER_AIS}" and status 'Pending'
    When user view selected CN/DN Detail
    Then Return Document button is available on view cndn page

    [Teardown]      Run Keywords    Set button configuration disable    return document    ${TRUE_MPID}    Pending
    ...             AND             Click 'X' mark to close 'View CNDN' page
    ...             AND             Reload page

Verify action button "print billing" button availability according to Buyer configuration
    [Tags]    Regression   Web    High    Ready
    [Documentation]    To Verify action button "print billing" button availability according to Buyer configuration and CNDNtype is Offline(6)
    Given set configuration of "print billing" button that have buyer "${TRUE_MPID}" to be available at status "Rejected" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Supplier name "${SUPPLIER_AIS}" and status 'Rejected'
    When user view selected CN/DN Detail
    Then Print billing button is available on view cndn page

    [Teardown]      Run Keywords    Set button configuration disable    print billing    ${TRUE_MPID}    Rejected
    ...             AND             Click 'X' mark to close 'View CNDN' page
    ...             AND             Reload page    

Verify action button "history" button availability according to Buyer configuration
    [Tags]    Regression   Web    High    Ready
    [Documentation]    To Verify action button "history button" availability according to Buyer configuration and CNDNtype is Offline(6)
    Given set configuration of "history" button that have buyer "${TRUE_MPID}" to be disable at status "Cancelled" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Supplier name "${SUPPLIER_AIS}" and status 'Cancelled'
    When user view selected CN/DN Detail
    Then History button should not be available on view cndn page

    [Teardown]      Run Keywords    Set button configuration available    history    ${TRUE_MPID}    Cancelled
    ...             AND             Click 'X' mark to close 'View CNDN' page
    ...             AND             Reload page    