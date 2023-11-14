*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml
Variables   ../../../resources/testdata/${env}/common/login.yaml

### Setup ###
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

*** Test Cases ***
Verify action button availability according to CN/DN status "Awaiting Approval"
    [Tags]    Ready    Regression    Web    High        
    [Documentation]    To Verify action button availability according to CN/DN status "Awaiting Approval"
    Given Go to menu manage CN/DN 
    and user select status filter "Awaiting Approval"
    When Click on action button
    Then print billing​ button​, history button should be available

Verify action button availability according to CN/DN status "Pending"
    [Tags]    Ready    Regression    Web    High   
    [Documentation]    To Verify action button availability according to CN/DN status "Pending"
    Given Go to menu manage CN/DN 
    and user select status filter "Pending"
    When Click on action button
    Then print billing​ button​, history button should be available

Verify action button availability according to CN/DN status "Completed"
    [Tags]    Ready    Regression    Web    High   
    [Documentation]    To Verify action button availability according to CN/DN status "Completed"
    Given Go to menu manage CN/DN 
    and user select status filter "Completed"
    When Click on action button
    Then cancel cndn button, print billing​ button​, history button should be available

Verify action button availability according to CN/DN status "Rejected"
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status "Rejected"
    Given Go to menu manage CN/DN 
    and user select status filter "Rejected"
    When Click on action button
    Then return document button​, history button should be available

Verify action button availability according to CN/DN status "Expired"
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status "Expired"
    Given Go to menu manage CN/DN 
    and user select status filter "Expired"
    When Click on action button
    Then history button should be available

Verify action button availability according to CN/DN status "Document Return"
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status "Document Return"
    Given Go to menu manage CN/DN 
    and user select status filter "Document Return"
    When Click on action button
    Then history button should be available

Verify action button availability according to CN/DN status "Cancelled"
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button availability according to CN/DN status "Cancelled"
    Given Go to menu manage CN/DN 
    and user select status filter "Cancelled"
    When Click on action button
    Then history button should be available

Verify action button "cancel cn/dn" button availability according to Buyer configuration
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button "cancel cn/dn" button availability according to Buyer configuration
    Given set configuration of "cancel cn/dn" button that have buyer "${BUYERMPID}" to be available at status "Awaiting Approval" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status "Awaiting Approval"
    When Click on action button
    Then cancel cn/dn should be available

    [Teardown]    Set button configuration disable    cancel cn/dn    ${BUYERMPID}    Awaiting Approval

Verify action button "return document​" button availability according to Buyer configuration
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button "return document​" button availability according to Buyer configuration
    Given set configuration of "return document" button that have buyer "${BUYERMPID}" to be available at status "Pending" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status "Pending"
    When Click on action button
    Then return document​ button should be available

    [Teardown]    Set button configuration disable    return document    ${BUYERMPID}    Pending

Verify action button "print billing" button availability according to Buyer configuration
    [Tags]    Ready    Regression    Web    High    
    [Documentation]    To Verify action button "print billing" button availability according to Buyer configuration
    Given set configuration of "print billing" button that have buyer "${BUYERMPID}" to be available at status "Rejected" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status "Rejected"
    When Click on action button
    Then print billing button should be available

    [Teardown]    Set button configuration disable    print billing    ${BUYERMPID}    Rejected

Verify action button "history" button availability according to Buyer configuration
    [Tags]    Ready    Regression    Web    High   
    [Documentation]    To Verify action button "history button" availability according to Buyer configuration
    Given set configuration of "history" button that have buyer "${BUYERMPID}" to be disable at status "Cancelled" 
    and Go to menu manage CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status "Cancelled"
    When Click on action button
    Then history button should not be available

    [Teardown]    Set button configuration available    history    ${BUYERMPID}    Rejected