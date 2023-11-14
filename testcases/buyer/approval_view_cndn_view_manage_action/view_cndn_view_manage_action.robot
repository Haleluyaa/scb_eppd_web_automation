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
### Page keyword releted ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_cndn_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml
Variables   ../../../resources/testdata/${env}/common/login.yaml

### Setup ###
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
test teardown       Reload page

*** Test Cases ***
Verify action button availability according to CN/DN status 'Awaiting'
    [Tags]    Ready    Regression    Web    High    TC_eINVOICE_02521    TC_eINVOICE_02522    TC_eINVOICE_02523    TC_eINVOICE_02524
    [Documentation]    To Verify action button availability according to CN/DN status 'Awaiting'
    Given Go to menu approval CN/DN 
    and user select CN/DN with status 'Awaiting'
    and Get target CN/DN No. at column "${TEXT.FILTER_CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Set value in DB for 'CN/DN status' as "${STATUS.AWAITING_APPROVAL}"
    and Reload Page
    and user select CN/DN with status 'Awaiting'
    When user view selected CN/DN Detail
    Then edit button, close invoice, print billing button, history button should be available

    [Teardown]       Run Keywords       Set value in DB for 'CN/DN status' as "${original_cndn_status}"
                         ...            Reload page  

Verify action button availability according to CN/DN status 'Approved'
    [Tags]    Ready    Regression    Web    High    TC_eINVOICE_02523    TC_eINVOICE_02524    TC_eINVOICE_02528    TC_eINVOICE_02529
    [Documentation]    To Verify action button availability according to CN/DN status 'Approved'
    Given Go to menu approval CN/DN 
    and user select CN/DN with status 'Approved'
    When user view selected CN/DN Detail
    Then print billing button, history button should be available

Verify action button availability according to CN/DN status 'Rejected'
    [Tags]    Ready    Regression    Web    High    TC_eINVOICE_02524    TC_eINVOICE_02528    TC_eINVOICE_02529    TC_eINVOICE_02530
    [Documentation]    To Verify action button availability according to CN/DN status 'Rejected'
    Given Go to menu approval CN/DN 
    and user select CN/DN with status 'Rejected'
    When user view selected CN/DN Detail
    Then history button should be available

Verify action button availability according to CN/DN status 'Processing'
    [Tags]    Ready    Regression    Web    High    TC_eINVOICE_02523    TC_eINVOICE_02524    TC_eINVOICE_02528    TC_eINVOICE_02529
    [Documentation]    To Verify action button availability according to CN/DN status 'Processing'
    Given Go to menu approval CN/DN 
    and user select CN/DN with status 'Processing'
    When user view selected CN/DN Detail
    Then print billing button, history button should be available

Verify action button 'close invoice' button availability according to Buyer configuration
    [Tags]    Regression    Web    High    TC_eINVOICE_02526
    [Documentation]    To Verify action button 'close invoice' button availability according to Buyer configuration
    Given Go to menu approval CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status 'Approved'
    When user view selected CN/DN Detail
    Then close invoice should be available

Verify action button 'print billing' button availability according to Buyer configuration
    [Tags]    Regression    Web    High    TC_eINVOICE_02527
    [Documentation]    To Verify action button 'print billing' button availability according to Buyer configuration
    Given Go to menu approval CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status 'Rejected'
    When user view selected CN/DN Detail
    Then print billing button should be available

Verify action button 'history button' availability according to Buyer configuration
    [Tags]    Regression    Web    High    TC_eINVOICE_02534
    [Documentation]    To Verify action button 'history button' availability according to Buyer configuration
    Given Go to menu approval CN/DN 
    and user select CN/DN with Buyer name "${BUYER_NAME}" and status 'Awaiting'
    When user view selected CN/DN Detail
    Then history button should not be available